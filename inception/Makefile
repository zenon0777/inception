up: 
	-mkdir -p /home/adaifi/data/wordpress /home/adaifi/data/DB /home/adaifi/data/adminer /home/adaifi/data/web-app
	-cd src && docker compose up --build
down:

	-cd src && docker compose down

clean:
	-cd src && docker compose down -v 
	-rm -rf /home/adaifi/data/wordpress
	-rm -rf /home/adaifi/data/DB
	-rm -rf /home/adaifi/data/adminer
	-rm -rf /home/adaifi/data/web-app
