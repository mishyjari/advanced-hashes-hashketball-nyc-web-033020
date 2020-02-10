data = {:meow => 'kitten'}

def game_hash
{
  :home => {
    :team_name => 'Brooklyn Nets',
    :colors => ['Black', 'White'],
    :players => [
      { 
        :player_name => 'Alan Anderson',
        :number => 0,
        :shoe => 16,
        :points => 22,
        :rebounds => 12,
        :assists => 12,
        :steals => 3,
        :blocks => 1,
        :slam_dunks => 1
      },
      { 
        :player_name => 'Reggie Evans',
        :number => 30,
        :shoe => 14,
        :points => 12,
        :rebounds => 12,
        :assists => 12,
        :steals => 12,
        :blocks => 12,
        :slam_dunks => 7
      },
      { 
        :player_name => 'Brook Lopez',
        :number => 11,
        :shoe => 17,
        :points => 17,
        :rebounds => 19,
        :assists => 10,
        :steals => 3,
        :blocks => 1,
        :slam_dunks => 15
      },
      { 
        :player_name => 'Mason Plumlee',
        :number => 1,
        :shoe => 19,
        :points => 26,
        :rebounds => 11,
        :assists => 6,
        :steals => 3,
        :blocks => 8,
        :slam_dunks => 5
      },
      { 
        :player_name => 'Jason Terry',
        :number => 31,
        :shoe => 15,
        :points => 19,
        :rebounds => 2,
        :assists => 2,
        :steals => 4,
        :blocks => 11,
        :slam_dunks => 1
      },      
    ]
  },
  :away => {
    :team_name => 'Charlotte Hornets',
    :colors => ['Turquoise', 'Purple'],
    :players => [
      { 
        :player_name => 'Jeff Adrien',
        :number => 4,
        :shoe => 18,
        :points => 10,
        :rebounds => 1,
        :assists => 1,
        :steals => 2,
        :blocks => 7,
        :slam_dunks => 2
      },
      { 
        :player_name => 'Bismack Biyombo',
        :number => 0,
        :shoe => 16,
        :points => 12,
        :rebounds => 4,
        :assists => 7,
        :steals => 22,
        :blocks => 15,
        :slam_dunks => 10
      },
      { 
        :player_name => 'DeSagna Diop',
        :number => 2,
        :shoe => 14,
        :points => 24,
        :rebounds => 12,
        :assists => 12,
        :steals => 4,
        :blocks => 5,
        :slam_dunks => 5
      },
      { 
        :player_name => 'Ben Gordon',
        :number => 8,
        :shoe => 15,
        :points => 33,
        :rebounds => 3,
        :assists => 2,
        :steals => 1,
        :blocks => 1,
        :slam_dunks => 0
      },
      { 
        :player_name => 'Kemba Walker',
        :number => 33,
        :shoe => 15,
        :points => 6,
        :rebounds => 12,
        :assists => 12,
        :steals => 7,
        :blocks => 5,
        :slam_dunks => 12
      },      
    ]
  }
} end

def player_stats(name) # returns stats of a player
  game_hash.reduce({}) do | memo, (key, value) |
    index = value[:players].index{|i| i[:player_name] == name}
    memo = value[:players].slice(index.to_i).reject{|k,v| k == :player_name} if index
    memo
  end
end

def num_points_scored(name) # Return number of points by player
  player_stats(name)[:points]
end

def shoe_size(name) # Shoe size by player
  player_stats(name)[:shoe]
end

def player_numbers(team) # Returns number on player jersey
  output = []
  team_data = game_hash.select { |k,v| v[:team_name] == team }
  team_data.reduce({}) do |memo, (key,value)|
    value[:players].each_index{|i| output << value[:players][i][:number]}
  end
  output
end


def team_colors(team) # Return colors by team name
  team_data = game_hash.select { |k,v| v[:team_name] == team }
  team_data.reduce({}) do |memo, (key,value)|
    memo = value[:colors]
    pp memo
  end
end

def team_names # Returns team names
output = []
  game_hash.each_value{ |v| output << v[:team_name] }
  output
end


def big_shoe_rebounds # Return number of rebounds of player with biggest shoe
  max_rebounds = { :shoe => 0, :rebounds => 0 }
  game_hash.reduce({}) do |memo, (key,value)|
    players = value[:players]
    players.each_index {|x| 
      shoe = players[x][:shoe]
      rebounds = players[x][:rebounds]
      if shoe > max_rebounds[:shoe]
        max_rebounds[:shoe] = shoe
        max_rebounds[:rebounds] = rebounds
      end }
      max_rebounds[:rebounds]
  end
end

def most_points_scored
  max = { :name => '', :points => 0 }
  game_hash.reduce({}) do |memo, (key,value)|
    players = value[:players]
    players.each_index {|i|
      name = players[i][:player_name]
      points = players[i][:points]
      if points > max[:points]
        max[:name] = name
        max[:points] = points
      end }
      max[:name]
  end
end

def winning_team
  winner = { :team => '', :score => 0 }
  game_hash.reduce({}) do |memo, (key,val)| 
    score = 0
    players = val[:players]
    players.each { |i| score += i[:points] }
    pp score
    if score > winner[:score]
      winner[:score] = score
      winner[:team] = val[:team_name]
    end
  end
  winner[:team]
end

def player_with_longest_name
  result = ''
  game_hash.reduce({}) do |memo, (key,val)| 
    players = val[:players]
    players.each { |i| 
      name = i[:player_name]
      result = name if name.length > result.length }
  end
  result
end

def long_name_steals_a_ton?
  long_name_steals = player_stats(player_with_longest_name)[:steals]
  def max_steals
    max = 0
    game_hash.reduce({}) do |memo, (key,value)|
    players = value[:players]
    players.each_index {|i|
      if players[i][:steals] > max
        max = players[i][:steals]
      end }
      max
    end
  end
  long_name_steals >= max_steals
end