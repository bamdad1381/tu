local apikey = 
'eeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjYzOTRlNGMwLTY0ZDItNDVlNS1hYmVhLTFkZDY2M2NhMTgwMyIsImlhdCI6MTQ1OTI0MDIzMSwic3ViIjoiZGV2ZWxvcGVyL2EyNTY0N2E4LWQwNjEtZDdlNi1hYjRmLWEzNGE0YTFiMzNkNiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjgyLjEwMi4xMy45OCJdLCJ0eXBlIjoiY2xpZW50In1dfQ.TTNEetGPs4X1_cEWRr1ARBjgz5sXYGjxgI0b4wirgYb2vr6S1m8fQBP8imt9rMGq7D8eafEDZVMn3QiBiSshAg'
local function run(msg, matches)
 if matches[1]:lower() == 'clan' or matches[1]:lower() == 'clash' or matches[1]:lower() == 'clantag' or matches[1]:lower() == 'tag' then
  local clantag = matches[2]
  if string.match(matches[2], '^#.+$') then
     clantag = string.gsub(matches[2], '#', '')
  end
  clantag = string.upper(clantag)
  local curl = 'curl -X GET --header "Accept: application/json" --header "authorization: Bearer '..apikey..'" "https://api.clashofclans.com/v1/clans/%23'..clantag..'"'
  cmd = io.popen(curl)
  
  local result = cmd:read('*all')
  local jdat = json:decode(result)
if jdat.reason then
      if jdat.reason == 'accessDenied' then return 'برای ثبت API Key خود به سایت زیر بروید\ndeveloper.clashofclans.com' end
   return '#Error\n'..jdat.reason
  end
  local text = '⚡Clan Tag: '.. jdat.tag
     text = text..'\n🔴Clan Name: '.. jdat.name
     text = text..'\n🔷Description: '.. jdat.description
     text = text..'\n🔶Type: '.. jdat.type
     text = text..'\n🔻War Frequency: '.. jdat.warFrequency
     text = text..'\n🔹Clan Level: '.. jdat.clanLevel
     text = text..'\n🔽War Wins: '.. jdat.warWins
     text = text..'\n🔸Clan Points: '.. jdat.clanPoints
     text = text..'\n🔼Required Trophies: '.. jdat.requiredTrophies
     text = text..'\n▫Members: '.. jdat.members
     text = text..'\n---------------\n@Turbo_Team'
     cmd:close()
  return text
 end
 if matches[1]:lower() == 'members' or matches[1]:lower() == 'clashmembers' or matches[1]:lower() == 'clanmembers' then
  local members = matches[2]
  if string.match(matches[2], '^#.+$') then
     members = string.gsub(matches[2], '#', '')
  end
  members = string.upper(members)
  local curl = 'curl -X GET --header "Accept: application/json" --header "authorization: Bearer '..apikey..'" "https://api.clashofclans.com/v1/clans/%23'..members..'/members"'
  cmd = io.popen(curl)
  local result = cmd:read('*all')
  local jdat = json:decode(result)
  if jdat.reason then
      if jdat.reason == 'accessDenied' then return 'برای ثبت API Key خود به سایت زیر بروید\ndeveloper.clashofclans.com' end
   return '#Error\n'..jdat.reason
  end
  local leader = ""
  local coleader = ""
  local items = jdat.items
  leader = 'Clan Moderators: \n'
   for i = 1, #items do
   if items[i].role == "leader" then
   leader = leader.."\nLeader: "..items[i].name.."\nLevel: "..items[i].expLevel
   end
   if items[i].role == "coLeader" then
   coleader = coleader.."\nCo-Leader: "..items[i].name.."\nLevel: "..items[i].expLevel
   end
  end
text = leader.."\n"..coleader.."\n\nClan Members:"
  for i = 1, #items do
  text = text..'\n'..i..'- '..items[i].name..'\nlevel: '..items[i].expLevel.."\n"
  end
  text = text.."\n---------------\n@Turbo_Team"
   cmd:close()
  return text
 end
end

return {
   patterns = {
"^[/#!](clash) (.*)$",
"^[/#!](clan) (.*)$",
"^[/#!](clantag) (.*)$",
"^[/#!](tag) (.*)$",
"^[/#!](clashmembers) (.*)$",
"^[/#!](clanmembers) (.*)$",
"^[/#!](members) (.*)$",
   },
   run = run
}
