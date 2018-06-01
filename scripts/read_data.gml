if file_exists('boomeraxe.ini')
{
    ini_open('boomeraxe.ini')
    
    global.best_time=ini_read_real('meta','best',-1)
    profile_count=ini_read_real('meta','profile_count',-1)
    
    global.leaderboard_version=ini_read_real('meta','version',0)
    
    global.profiles=ds_grid_create(11,profile_count)
    
    new_profiles=ds_list_create()
    a=0
    
    for (i=0;i!=profile_count;i++)
    {
        name=ini_read_string('meta',string(i),'')

        if ini_read_real(name,'run_count',0)!=0
        {    
            global.profiles[#0,i-a]=name
            global.profiles[#1,i-a]=ini_read_real(name,'best_time',0)
            global.profiles[#2,i-a]=ini_read_string(name,'best_date',0)
            global.profiles[#3,i-a]=ini_read_real(name,'run_count',0)
            
            ds_grid_resize(global.profiles,max(ds_grid_width(global.profiles),(global.profiles[#3,i-a]+1)*6+11),profile_count)
        
            for (z=0;z!=global.profiles[#3,i-a]*6;z+=6)
            {
                global.profiles[#z+4,i-a]=ini_read_real(name,string(z/6)+'0',0)    // Runtime
                global.profiles[#z+5,i-a]=ini_read_string(name,string(z/6)+'1',0)  // Date 
                global.profiles[#z+6,i-a]=ini_read_real(name,string(z/6)+'2',0)    // Kills
                global.profiles[#z+7,i-a]=ini_read_real(name,string(z/6)+'3',0)    // Deaths
                global.profiles[#z+8,i-a]=ini_read_real(name,string(z/6)+'4',0)    // Jumps
                global.profiles[#z+9,i-a]=ini_read_real(name,string(z/6)+'5',0)    // Dashes
            }
            
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+0,i-a]=ini_read_real(name,'up',vk_up)
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+1,i-a]=ini_read_real(name,'down',vk_down)
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+2,i-a]=ini_read_real(name,'left',vk_left)
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+3,i-a]=ini_read_real(name,'right',vk_right)
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+4,i-a]=ini_read_real(name,'jump',ord('Z'))
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+5,i-a]=ini_read_real(name,'throw',ord('X'))
            global.profiles[#4+(global.profiles[#3,i-a]+1)*6+6,i-a]=ini_read_real(name,'dash',vk_shift)
        }
        else
        {
            ds_list_add(new_profiles,name)
            ds_list_add(new_profiles,undefined)
            ds_list_add(new_profiles,ini_read_real(name,'up',vk_up))
            ds_list_add(new_profiles,ini_read_real(name,'down',vk_down))
            ds_list_add(new_profiles,ini_read_real(name,'left',vk_left))
            ds_list_add(new_profiles,ini_read_real(name,'right',vk_right))
            ds_list_add(new_profiles,ini_read_real(name,'jump',ord('Z')))
            ds_list_add(new_profiles,ini_read_real(name,'throw',ord('X')))
            ds_list_add(new_profiles,ini_read_real(name,'dash',vk_shift))
            a+=1
        }         
    }
    
    ds_grid_resize(global.profiles,ds_grid_width(global.profiles),profile_count-a)
    ds_grid_sort(global.profiles,1,1)
    ds_grid_resize(global.profiles,ds_grid_width(global.profiles),profile_count)
    
    for (i=0;i!=ds_list_size(new_profiles);i+=9)
    {
        z=profile_count-a+i/9
        global.profiles[#0,z]=new_profiles[| i+0]
        global.profiles[#1,z]=new_profiles[| i+1]
        global.profiles[#2,z]=new_profiles[| i+2]
        global.profiles[#3,z]=new_profiles[| i+3]
        global.profiles[#4,z]=new_profiles[| i+4]
        global.profiles[#5,z]=new_profiles[| i+5]
        global.profiles[#6,z]=new_profiles[| i+6]
        global.profiles[#7,z]=new_profiles[| i+7]
        global.profiles[#8,z]=new_profiles[| i+8]       
    }
        
    ini_close()
}

