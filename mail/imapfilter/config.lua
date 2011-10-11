options.timeout = 120
options.subscribe = true

cmd = io.popen('gpg --no-tty --use-agent -q -d ~/.imapfilter/jkweb.password.gpg', 'r')
out = cmd:read('*a')
pass = string.gsub(out, '[\n\r]+', '')

jkweb = IMAP {
	server = 'jkweb.ca',
	username = 'linolium',
	password = pass
}

source = 'INBOX'

--------------------------------------------------------------------------
-- CUSTOM
--------------------------------------------------------------------------

-- Move all Facebook messages
dest = 'INBOX.Facebook'
print('Moving Facebook messages from ' .. source .. ' to ' .. dest)
msgs = jkweb[source]:match_from('@facebookmail.com')
jkweb[source]:move_messages(jkweb[dest], msgs)

-- Move all pride-ubc-announce messages
dest = 'Mailing Lists.Pride UBC'
print('Moving pride-ubc-announce messages from ' .. source .. ' to ' .. dest)
msgs = jkweb[source]:match_to('pride-ubc-announce@googlegroupse.com')
jkweb[source]:mark_seen(msgs)
jkweb[source]:move_messages(jkweb[dest], msgs)

-- Move all Seaside-dev messages
dest = 'Mailing Lists.Seaside-dev'
print('Moving Seaside-dev messages from ' .. source .. ' to ' .. dest)
msgs = jkweb[source]:match_to('seaside-dev@lists.squeakfoundation.org')
jkweb[source]:mark_seen(msgs)
jkweb[source]:move_messages(jkweb[dest], msgs)

-- Move all Cron/unrealircd messages
dest = 'Trash'
print('Moving Cron/unrealircd messages from ' .. source .. ' to ' .. dest)
msgs = jkweb[source]:match_subject('Cron <unrealircd@plebb>')
jkweb[source]:mark_seen(msgs)
jkweb[source]:move_messages(jkweb[dest], msgs)


--------------------------------------------------------------------------
-- NOTES
--------------------------------------------------------------------------

-- Inbox information
--jkweb.INBOX:check_status()

-- Get and print available mailboxes and folders
--mailboxes, folders = jkweb:list_all()
--table.foreach(mailboxes,print)
--table.foreach(folders,print)

-- msgs = amazon.INBOX:select_all()
-- amazon.INBOX:mark_seen(msgs)
-- amazon:delete_mailbox('lists/' .. list)
