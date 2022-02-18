.PHONY: tests install fixtures database prepare tests phpstan php-cs-fixer composer-valid doctrine analyze

install:
	composer install
	make prepare env=$(env)

fixtures:
	symfony console doctrine:fixtures:load -n --env=$(env)

database:
	symfony console doctrine:database:drop --if-exists --force --env=$(env)
	symfony console doctrine:database:create --env=$(env)
	symfony console doctrine:query:sql "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));" --env=$(env)
	symfony console doctrine:schema:update --force --env=$(env)

prepare:
	make database env=$(env)
	make fixtures env=$(env)

tests:
	symfony php bin/phpunit --testdox

phpstan:
	php vendor/bin/phpstan analyse -c phpstan.neon

php-cs-fixer:
	symfony php vendor/bin/php-cs-fixer fix

composer-valid:
	composer valid

doctrine:
	symfony console doctrine:schema:valid --skip-sync

twig:
	symfony console lint:twig templates

yaml:
	symfony console lint:yaml config translations

container:
	symfony console lint:container

analyze: twig yaml composer-valid container doctrine phpstan