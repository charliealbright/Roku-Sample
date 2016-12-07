function init()
    m.top.functionName = "getContent"
end function

function getContent()

    url = m.top.url
    if (url <> "")
        request = CreateObject("roUrlTransfer")
        port = CreateObject("roMessagePort")
        request.setUrl(url)
        request.setMessagePort(port)
        request.setCertificatesFile("common:/certs/ca-bundle.crt")
        continue = true
        if (request.AsyncGetToString())
            while (continue)
                msg = wait(0, port)
                if (type(msg) = "roUrlEvent")
                    code = msg.GetResponseCode()
                    if (code = 200)
                        m.top.data = ParseJSON(msg.GetString())
                    else
                        m.top.data = invalid
                    end if
                    continue = false
                end if
            end while
        end if
    end if
end function
