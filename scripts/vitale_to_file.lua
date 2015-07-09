-- File: vitale_to_file
-- Version: 0.0.1
-- Author: Charles-Antoine Sohier
-- Date: 5/07/2015
--

-- This script should be run on cardpeek, it could be use as follow:
--        $ cardpeek --console
--        > dofile("vitale_to_file.lua")



-- TODO Automatically connect pcsc card reader.
-- TODO First run atr.lua script to check whether the available card is actually a vitale card.

-- First run vitale_2 to extract data from the vitale card.
-- This script is embedded in cardpeek. It creates nodes that can be easily parsed.

dofile("vitale_2.lua")


-- Tries to open a file.
-- TODO changes output text to something more generic.
file = io.open("/Users/Chazz/Desktop/test.txt", "w")
-- if it fails, logs an error.
if(file == nil) then
  log.print(3, "cannot open file")
else
  log.print(1, "file successfully opened")
end


-- TODO find a fallback in case of the file is not open.
-- Changes the output to the recently opened file.
io.output(file);

-- Parses the nodes to find the pieces of informations required.
-- Those strings are not encrypted on micro-chip card.
-- TODO rewrite the find method, in order to parse only once the nodes.

local root = nodes.root()
local name = root:find_first({label="Nom"}):get_attribute("alt")
local forname = root:find_first({label="Prénom"}):get_attribute("alt")
local birthdate = root:find_first({label="Date de naissance"}):get_attribute("alt")
local nationality = root:find_first({label="Nationalité"}):get_attribute("alt")
local number = root:find_first({label="Numéro de sécurité sociale"}):get_attribute("alt")

-- Logs the informations on cardpeek log utility.

log.print(1, "name:\t" .. name  )
log.print(1, "forname:\t" .. forname)
log.print(1, "birthdate:\t" .. birthdate)
log.print(1, "nationality:\t" .. nationality)
log.print(1, "number:\t" .. number)

-- TODO maybe encrypt data before storing it on the server?

-- Write down the data on the text file opened before.
io.write(name .. "\n")
io.write(forname .. "\n")
io.write(birthdate .. "\n")
io.write(nationality .. "\n")
io.write(number .. "\n")

-- Finally close the file, end of the script.
io.close()
