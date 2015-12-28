class Budgie < ActiveRecord::Base
  validates :name, presence: true
  validates :color_id, presence: true
  validates :father_id, presence: true
  validates :mother_id, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def descendents
    self.class.descendents_for(self) - [self]
  end

  def self.descendents_for(instance)
    where("#{table_name}.id IN (#{descendents_id_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.descendents_id_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE tree AS (
        SELECT *
        FROM #{table_name}
        WHERE id = #{instance.id}

        UNION ALL

        SELECT #{table_name}.*
        FROM tree
        JOIN #{table_name} ON #{table_name}.father_id = tree.id OR #{table_name}.mother_id = tree.id
      )
      SELECT id FROM tree ORDER BY id
    SQL
  end

  def ancestors
    self.class.ancestors_for(self) - [self]
  end

  def self.ancestors_for(instance)
    where("#{table_name}.id IN (#{ancestors_id_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.ancestors_id_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE tree AS (
        SELECT *
        FROM #{table_name}
        WHERE id = #{instance.id}

        UNION ALL

        SELECT #{table_name}.*
        FROM tree
        JOIN #{table_name} ON #{table_name}.id = tree.father_id OR #{table_name}.id = tree.mother_id
      )
      SELECT id FROM tree ORDER BY id
    SQL
  end

end
