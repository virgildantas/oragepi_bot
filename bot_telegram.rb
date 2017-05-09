require 'telegram/bot'
require 'usagewatch' 

token = "Colocar o token de seu bot aqui" 

help="Este é o menu de ajuda:
	/disk_status - mostra a percentagem de espaço usado em /torrent.
	/chat_id - mostra qual o id do chat, seja grupo ou conversa com o bot.
	/tem_status - mostra a temperatura de CPU.
	/cpu_status - mostra o uso de cpu em percentagem, cada núcleo utilizado em seu máxio equivale a 25% do uso de cpu.
	/status_geral - mostra u status geral do orange, disco, cpu, memória e alguns processos rodando.
	/transmission_status - mostra o staus do transmission-daemo.
	/samba_status - mostra o status do serviço smbd.
	/netstat - mostra o resultado do netstat com os parametros: -nltp.
	"

arquivo_pid = 'bot_telegram.pid' 
pid = Process.pid
File.open(arquivo_pid, 'w') { |file| file.write(pid) }

Telegram::Bot::Client.run(token) do |bot|
  bot.logger.info("Este é o menu de ajuda:
	/disk_status - mostra a percentagem de espaço usado em /torrent.
	/chat_id - mostra qual o id do chat, seja grupo ou conversa com o bot.
	/temp_status - mostra a temperatura de CPU.
	/cpu_status - mostra o uso de cpu em percentagem, cada núcleo utilizado em seu máxio equivale a 25% do uso de cpu.
	/status_geral - mostra u status geral do orange, disco, cpu, memória e alguns processos rodando.
	")

  bot.listen do |message|
    if(message.chat.id == 132560166  || message.chat.id == 16206259)then
     if(message.text == '/help')then 
      bot.api.send_message(chat_id: message.chat.id, text: help)
     elsif(message.text == '/disk_status')then
	disk_pfree = %x(df -h /torrent | grep ^/ | awk '{ print $5;}')
      bot.api.send_message(chat_id: message.chat.id, text: "Espaço usado em disco: #{disk_pfree}\n")
     elsif(message.text == '/temp_status')then
	temp_status = %x(cat /etc/armbianmonitor/datasources/soctemp)	
      bot.api.send_message(chat_id: message.chat.id, text: "Temperatura de CPU: #{temp_status}°C\n")
     elsif(message.text == '/cpu_status')then
	cpu_status = %x(top -b -n 1 | grep kswapd | awk '{print $9}')
      bot.api.send_message(chat_id: message.chat.id, text: "O uso dos 4 núcleos está em: #{cpu_status}%\n")
     elsif(message.text == '/status_geral')then
		status_geral =  '' 
		usw = Usagewatch
		status_geral = "#{status_geral} \n#{usw.uw_diskused} Gigabytes Used"
		status_geral = "#{status_geral} \n#{usw.uw_diskused_perc} Perventage of Gigabytes Used"
		status_geral = "#{status_geral} \n#{usw.uw_cpuused}% CPU Used"
		status_geral = "#{status_geral} \n#{usw.uw_tcpused} TCP Connections Used"
		status_geral = "#{status_geral} \n#{usw.uw_udpused} UDP Connections Used"
		status_geral = "#{status_geral} \n#{usw.uw_memused}% Active Memory Used"
		status_geral = "#{status_geral} \n#{usw.uw_load} Average System Load Of The Past Minute"
		status_geral = "#{status_geral} \n#{usw.uw_bandrx} Mbit/s Current Bandwidth Received"
		status_geral = "#{status_geral} \n#{usw.uw_bandtx} Mbit/s Current Bandwidth Transmitted"
		status_geral = "#{status_geral} \n#{usw.uw_diskioreads}/s Current Disk Reads Completed"
		status_geral = "#{status_geral} \n#{usw.uw_diskiowrites}/s Current Disk Writes Completed"
		status_geral = "#{status_geral} \nTop Ten Processes By CPU Consumption: #{usw.uw_cputop}"
		status_geral = "#{status_geral} \nTop Ten Processes By Memory Consumption: #{usw.uw_memtop}"
	      bot.api.send_message(chat_id: message.chat.id, text: "Status geral:\n#{status_geral}")
     elsif(message.text == '/transmission_status')then
	   transmission_status = %x(service transmission-daemon status | grep -i active | awk '{ print $2 $3;}')
      	   bot.api.send_message(chat_id: message.chat.id, text: "O serviço transmission-daemon está: #{transmission_status}")
     elsif(message.text == '/samba_status')then
	   smb_status = %x(service smbd status | grep -i active | awk '{ print $2 $3;}') 
      	   bot.api.send_message(chat_id: message.chat.id, text: "O serviço smbd está: #{smb_status}") 
      elsif( message.text == '/netstat')then
	    netstat_nltp = %x(netstat -nltp)
      	   bot.api.send_message(chat_id: message.chat.id, text: netstat_nltp) 
	end


    case message.text
    when '/chat_id'
      bot.api.send_message(chat_id: message.chat.id, text: "Chat id: #{message.chat.id}")
	 
    end
   else 
	 bot.api.send_message(chat_id: message.chat.id, text: "Desculpe @#{message.from.username}, você não tem permissão para interagir com este bot. Obrigado!")
   end ##fim if(message.chat.id == '132560166') Verifica se o chat está com permissão para interagir
  end
end
