# oragepi_bot
--bot telegram para um moitorameto simples de um orange pi, espaço livre em disco, serviços e mais para o futuro.
--Adicionar ao /etc/crontab
	0,15,30,45,50 * * * * root  export DISPLAY=:0 && /opt/orangepi_bot/bot_telegram.watchdog.sh



-> Este Ã© o menu de ajuda:
 	 /disk_status - mostra a percentagem de espaÃ§o livre em /torrent.
	 /chat_id - mostra qual o id do chat, seja grupo ou conversa com o bot.
	 /temp_status - mostra a temperatura de CPU.
	 /cpu_status - mostra o uso de cpu em percentagem, cada nÃºcleo utilizado em seu mÃ¡xio equivale a 25% do uso de cpu.
	 /status_geral - mostra u status geral do orange, disco, cpu, memÃ³ria e alguns processos rodando.
   /netstat - executa o comando "netstat -nltp" e mostra o resultado. 

->Para iniciar o bot execute o comando abaixo:
	ruby bot_telegram.rb &

