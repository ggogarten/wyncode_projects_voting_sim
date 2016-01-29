# voting_sim_methodlib.rb


require "./voting_sim_classes.rb"

module Voting_Sim_Methodlib

  def query
    gets.chomp.downcase
  end

  def query_name
    gets.chomp.capitalize
  end

  # def population_start_of_time
  #   @pol_array = []
  #   @ppl_array = []
  # end

  def population_start_of_time
    @pol_array = [
       {"Trump" => "Republican"},
       {"Clinton" => "Democrat"},
     ]
    @ppl_array = [
       {"George" => "Liberal"},
       {"John" => "Neutral"},
     ]
  end

  def main_menu
    puts """

    --------Voter Database Simulator---------
    ---------Glück Development Labs----------
    *************************************************************
    (C)reate a new politician or voter
    (L)ist the current database entries
    (U)pdate a value
    (D)elete
    (E)xit
    *************************************************************
    """

    option = query
    case option
    when "c"
      create()
    when "l"
      list(@ppl_array, @pol_array)
    when "u"
      update()
    when "d"
      delete_who()
    when "e"
      puts "You're fired!"
      exit
    else
      puts "You're almost FIRED, pick a letter come on!"
      main_menu()
      # not working properly
    end
  end

  def create
    puts "What would you like to create?
    (P)olitician or (V)oter"
    create_who = query
    if create_who == "p"
      # pol_array = [] was put here initially for testing
      puts "Another Politician? Ok, gimme their name."
      @name = query_name
      puts """What party do they belong to?
      (R)epublican
      (D)emocrat
      """
      @p_party = query
      @new_politician = Politician.new(@name, @p_party)
      puts @new_politician.name + " " + @new_politician.p_party
      pol_hash = {@new_politician.name => @new_politician.p_party}
      @pol_array << pol_hash
      puts @pol_array
      main_menu
    elsif create_who == "v"
      puts "What's their name?"
      @name = query_name
      puts """What is their political tendency?
      (L)iberal
      (C)onservative
      (T)ea Party
      (S)ocialist
      (N)eutral)"""
      @politics = query
      @new_person = Person.new(@name, @politics)
      puts @new_person.name + " " + @new_person.politics
      ppl_hash = {@new_person.name => @new_person.politics}
      @ppl_array << ppl_hash
      puts @ppl_array
      main_menu
    else
      puts "@createbot: No one created."
    end
  end

  def list (ppl_array, pol_array)

    puts """
    --------Voter Database------------------------------------
    ----------------------------------------------------------
    """

    puts @ppl_array

    puts """
    --------Politician Database-------------------------------
    ----------------------------------------------------------
    """
    puts @pol_array
    main_menu
  end


  def update
    puts"Do you want to update a (P)olitician or a (V)oter?"
    pol_or_ppl = query
    puts "What would you like to update? (N)ame or (P)olitical Afiliation"
    change_cat = query
    puts "For who?"
    if pol_or_ppl == "v"
      puts "Voters: "
      puts @ppl_array
    else
      puts "Politicians: "
      puts @pol_array
    end
    who = query_name
    if change_cat == "n" and pol_or_ppl == "v"
      puts "What do you want to call this voter?"
      to = query_name
      change_name_people(who, to)
      main_menu
    elsif change_cat == "p" and pol_or_ppl == "v"
      puts """
      What is the new political affiliation for this voter?
      (L)iberal
      (C)onservative
      (T)ea Party
      (S)ocialist
      (N)eutral
      """
      new_politics = query
      change_politics(who, new_politics)
      main_menu
    elsif change_cat == "n" and pol_or_ppl == "p"
      puts "What do you want to call this politician?"
      to = query_name
      change_name_politician(who, to)
      main_menu
    elsif change_cat == "p" and pol_or_ppl == "p"
      puts """
      What is the new party for this politician?
      (R)epublican
      (D)emocrat
      """
      new_politics = query
      change_politics(who, new_politics)
      main_menu
    else
      puts "Invalid entry"
      update
    end
  end

  def delete_who
    puts"Do you want to delete a (P)olitician or a (V)oter?"
    pol_or_ppl = query
    if pol_or_ppl == "v"
      puts "Voters: "
      puts @ppl_array
      puts "Which one?"
      @who_del = query_name
      puts @who_del
      puts @who_del.class
      del_ppl(@who_del)
    else
      puts "Politicians: "
      puts @pol_array
      puts "Which one?"
      @who_del = query_name
      puts @who_del
      puts @who_del.class
      del_pol(@who_del)

    end
  end


########################## change and del methods ##############################

  def del_pol(who)
    # puts who
    # main_menu
    @pol_array.each do |key|
      # puts who.class
      if key.has_key?(@who_del)
        puts "ok"
        who_del_values = key.values
        puts who_del_values
        who_del_values = who_del_values[0].to_s
        expunged = {@who_del => who_del_values}
        puts @pol_array
        puts expunged
        @pol_array.delete(expunged)
        puts "******************"
        puts @pol_array
        main_menu
      end
    end
  end

  def del_ppl(who)
    # puts who
    # main_menu
    @ppl_array.each do |key|
      # puts who.class
      if key.has_key?(@who_del)
        puts "ok"
        who_del_values = key.values
        puts who_del_values
        who_del_values = who_del_values[0].to_s
        expunged = {@who_del => who_del_values}
        puts @ppl_array
        puts expunged
        @ppl_array.delete(expunged)
        puts "******************"
        puts @ppl_array
        main_menu
      end
    end
  end



  def change_name_people (who, to)
    @ppl_array.each do |key|
      if key.has_key?(who)
        puts "Name Found!"
        # puts key
        # key <= @modify_to
        puts "Old name: "
        puts key.keys
        puts ""
        puts "New name: "
        puts to
        # puts key.values
        p_values = key.values
        # puts p_values.class
        p_values = p_values[0].to_s
        # puts p_values.class
        key = {to => p_values}
        # puts key
        @ppl_array << key
        old_ppl = {who => p_values}
        # puts old_ppl
        puts "dirty array"
        puts @ppl_array
        @ppl_array.delete(old_ppl)
        puts "clean array"
        puts @ppl_array
        # puts @ppl_array
        # puts who
        # puts to
        # puts who
        # # old_name = who
        # puts to
      else
        puts "Name not found. Please check your spelling."
        puts who
      end
    end
  end

  def change_name_politician (who, to)
    @pol_array.each do |key|
      if key.has_key?(who)
        puts "Name Found!"
        # puts key
        # key <= @modify_to
        puts "Old name: "
        puts key.keys
        puts ""
        puts "New name: "
        puts to
        # puts key.values
        p_values = key.values
        # puts p_values.class
        p_values = p_values[0].to_s
        # puts p_values.class
        key = {to => p_values}
        # puts key
        @pol_array << key
        old_ppl = {who => p_values}
        # puts old_ppl
        puts "dirty array"
        puts @pol_array
        @pol_array.delete(old_ppl)
        puts "clean array"
        puts @pol_array
        # puts @ppl_array
        # puts who
        # puts to
        # puts who
        # # old_name = who
        # puts to
      else
        puts "Name not found. Please check your spelling."
        puts who
      end
    end
  end


  # change_name_people(@modify_who, @modify_to)

  def change_politics (who, new_politics)
    @ppl_array.each do |key|
      if key.has_key?(who)
        puts "Name Found!"
        puts ""
        puts ""
        # puts key
        # key <= @modify_to
        puts "Old politics: "
        oldpol = key.values
        oldpol = oldpol[0].to_s
        puts oldpol.class
        puts oldpol
        puts ""
        puts "New politics: "
        puts new_politics
        p_values = new_politics
        # puts p_values.class
        # p_values = p_values.to_s
        # puts p_values.class
        key = {who => p_values}
        # puts key
        @ppl_array << key
        old_ppl = {who => oldpol}
        # puts old_ppl
        # puts "dirty array"
        # puts @ppl_array
        @ppl_array.delete(old_ppl)
        puts "clean array"
        puts @ppl_array
        # puts @ppl_array
        # # puts who
        # # puts to
        # # puts who
        # # # old_name = who
        # # puts to
        # else
        #   puts "Name not found. Please check your spelling."
        #   puts who
      end
    end
  end
end
# change_politics(@modify_who, @new_politics)
