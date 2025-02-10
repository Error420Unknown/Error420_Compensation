RegisterNetEvent('openCompensationAdminMenu', function()
    lib.registerContext({
        id = 'compensation_menu',
        title = 'Create Compensation',
        options = {
            {
                title = 'Item Compensation',
                description = 'Create a compensation code for items.',
                event = 'Error420_Compensation:createItemComp'
            },
            {
                title = 'Vehicle Compensation',
                description = 'Create a compensation code for vehicles.',
                event = 'Error420_Compensation:createVehicleComp'
            }
        }
    })

    lib.showContext('compensation_menu')
end)

RegisterNetEvent('Error420_Compensation:createItemComp', function()
    local codeInput = lib.inputDialog("Create Compensation Code", {
        { type = "input", label = "Enter Code", placeholder = "XXXXX-XXXXX" }
    })

    if not codeInput or not codeInput[1] then
        lib.notify({ type = 'error', description = 'Invalid code input!' })
        return
    end

    local code = codeInput[1]
    local items = {}
    local addingItems = true

    while addingItems do
        local itemInput = lib.inputDialog("Add Item", {
            { type = "input", label = "Item Name", placeholder = "money, weapon_pistol, etc." },
            { type = "number", label = "Amount", min = 1, placeholder = "1, 10, 100" }
        })

        if itemInput and itemInput[1] and itemInput[2] then
            table.insert(items, { item = itemInput[1], amount = itemInput[2] })

            local continueInput = lib.inputDialog("Add More?", {
                { type = "input", label = "Type 'yes' to add another item", placeholder = "yes / no" }
            })

            if not continueInput or continueInput[1]:lower() ~= "yes" then
                addingItems = false
            end
        else
            lib.notify({ type = 'error', description = 'Invalid item input!' })
            break
        end
    end

    if #items > 0 then
        local success = lib.callback.await("Error420_Compensation:createCode", false, { code = code, items = items, type = "item" })

        if success then
            lib.notify({ type = 'success', description = 'Item Compensation Code Created!' })
        else
            lib.notify({ type = 'error', description = 'Failed to create compensation code!' })
        end
    end
end)

RegisterNetEvent('Error420_Compensation:createVehicleComp', function()
    local codeInput = lib.inputDialog("Create Compensation Code", {
        { type = "input", label = "Enter Code", placeholder = "XXXXX-XXXXX" }
    })

    if not codeInput or not codeInput[1] then
        lib.notify({ type = 'error', description = 'Invalid code input!' })
        return
    end

    local code = codeInput[1]

    local vehicleInput = lib.inputDialog("Vehicle Compensation", {
        { type = "input", label = "Vehicle Model", placeholder = "e.g., adder, t20" },
        { type = "input", label = "Vehicle Plate", placeholder = "Custom Plate" },
        { type = "input", label = "Mods (JSON Format, Optional)", placeholder = "{}" }
    })

    if vehicleInput and vehicleInput[1] and vehicleInput[2] then
        local vehicleData = {
            model = vehicleInput[1],
            plate = vehicleInput[2],
            mods = vehicleInput[3] or "{}"
        }

        local success = lib.callback.await("Error420_Compensation:createCode", false, { code = code, vehicle = vehicleData, type = "vehicle" })

        if success then
            lib.notify({ type = 'success', description = 'Vehicle Compensation Code Created!' })
        else
            lib.notify({ type = 'error', description = 'Failed to create compensation code!' })
        end
    else
        lib.notify({ type = 'error', description = 'Invalid vehicle input!' })
    end
end)

RegisterNetEvent('openCompensationClaimMenu', function()
    local input = lib.inputDialog("Claim Compensation", {
        { type = "input", label = "Enter Code", placeholder = "XXXXX-XXXXX" }
    })

    if input and input[1] then
        local success = lib.callback.await("Error420_Compensation:claimCode", false, { code = input[1] })
        if success then
            lib.notify({ type = 'success', description = 'Compensation claimed successfully!' })
        else
            lib.notify({ type = 'error', description = 'Failed to claim compensation!' })
        end
    else
        lib.notify({ type = 'error', description = 'Invalid code!' })
    end
end)
