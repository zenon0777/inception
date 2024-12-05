up: 
	-mkdir -p /home/adaifi/data/wordpress /home/adaifi/data/db /home/adaifi/data/adminer /home/adaifi/data/web-app
	-cd srcs && docker-compose up -d --build
down:

	-cd srcs && docker-compose down

clean:
	-cd srcs && docker-compose down -v 
	-sudo rm -rf /home/adaifi/data/wordpress
	-sudo rm -rf /home/adaifi/data/db
	-sudo rm -rf /home/adaifi/data/adminer
	-sudo rm -rf /home/adaifi/data/web-app
