game <- function(){
    rule_df <- data.frame(Rule=c("Rock","Paper","Scissors"),Rock=c("T","W","L"),Paper=c("L","T","W"),Scissors=c("W","L","T"))
    print(rule_df,row.names=F)
    writeLines(c("","Hello !","Select your moves","1) Rock","2) Paper","3) Scissors","4) Exit",""),)
    round <- 1
    main <- function(){
        while(TRUE) {
        flush.console()
        player_action <- as.numeric(readline("You select: "))
        if (player_action %in% c(1,2,3,4)){
            if (player_action == 4){
              cat("Quit game !","\n")
              break
            }
            else{
              bot_action <- sample(1:3,1)
              result1 <- show_result(player_action,bot_action,round)
              round <- round + 1
            }
        }
        else{
            print("Wrong input! plz select number 1 2 3 4 ")
            break
        }
        }
    }
    show_result <- function(player_action,bot_action,round){
        cat("Round :", round ,"\n")
        cat("You select :", rule_df[player_action,1] ,"\n")
        cat("Bot select :", rule_df[bot_action,1] ,"\n")
        result <- rule_df[player_action,bot_action+1]
        cat("----------------------------------------","\n")
        if (result =="W"){
            cat("       You won !","\n")
        }
        if (result =="L"){
            cat("       You lost !","\n")
        }
        if (result =="T"){
            cat("       Tie !","\n")
        }
        cat("----------------------------------------","\n")
        }
    main()
}
game()
