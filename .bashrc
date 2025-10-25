@@ -1,4 +1,5 @@                                                                                                                                                                                             
 # ~/.bashrc: executed by bash(1) for non-login shells.                                                                                                                                                     
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion                                                                                                       
 export OPENAI_API_KEY="sk-REPLACE_WITH_YOUR_KEY"                                                                                                                                                           
 export OPENAI_API_KEY="***REMOVED***"               
 export $(grep -v "^#" ~/metabo-immune-niches/.env | xargs)                                                                                                                                                 
-# === Project-scoped command audit for metabo-immune-niches (improved) ===                                                                                                                                 
+# === Project-scoped command audit for metabo-immune-niches (universal clean version) ===                                                                                                                  
 if [[ "$PWD" == *"metabo-immune-niches"* ]]; then                                                                                                                                                          
   export PROMPT_COMMAND='                                                                                                                                                                                  
     if [[ "$PWD" == *"metabo-immune-niches"* ]]; then                                                                                                                                                      
-      this_command=$(history 1 | sed "s/^ *[0-9]\+ *//")                                                                                                                                                   
-      echo "$(date +%F_%T) : $(pwd) : $this_command" >> ~/metabo-immune-niches/results/logs/command_history.log                                                                                            
+      # Capture the most recent command reliably (without line numbers)                                                                                                                                    
+      this_command=$(history 1 | awk "{\$1=\"\"; sub(/^ +/, \"\"); print}")                                                                                                                                
+      printf "%s : %s : %s\n" "$(date +%F_%T)" "$(pwd)" "$this_command" >> ~/metabo-immune-niches/results/logs/command_history.log"                                                                        
     fi                                                                                                                                                                                                     
   '                                                                                                                                                                                                        
 fi                                                                                                                                                                                                         
 # === End audit block ===                                                                                                                                                                                  
                              