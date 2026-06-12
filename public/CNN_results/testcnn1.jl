using NPZ

function simulate_early_stopping(val_loss, patience)
    best_loss = Inf
    wait = 0
    best_epoch = 0
    
    for (epoch, loss) in enumerate(val_loss)
        if loss < best_loss
            best_loss = loss
            best_epoch = epoch
            wait = 0
        else
            wait += 1
        end
        
        if wait >= patience
            println("Patience $patience -> Stopped at epoch $epoch | Best Loss: $best_loss (found at epoch $best_epoch)")
            return best_loss
        end
    end
    
    println("Patience $patience -> Finished all epochs | Best Loss: $best_loss (found at epoch $best_epoch)")
    return best_loss
end

# Load your CNN1 data
data = npzread("run_artifacts/results64.npz")
val_loss_cnn1 = data["val_loss"]

# Compare the two
println("--- CNN1 Early Stopping Check ---")
simulate_early_stopping(val_loss_cnn1, 20)
simulate_early_stopping(val_loss_cnn1, 50)
