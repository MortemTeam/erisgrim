
/datum/controller/subsystem/inactivity/fire(resumed = FALSE)
    . = ..()
    for(var/client/C in clients)
        var/mob/M = C.mob
        if(M && M.mind && M.stat != DEAD)
            if(M.mind.assigned_job && M.mind.assigned_job.department)
                var/department = M.mind.assigned_job.department
                if(M.mind.assigned_job.title == "Vagabund")
                    department = "Vagabund"

                redis_client.push("DISCORD-SYSTEM", "PLAYED [department] [C.key]")
