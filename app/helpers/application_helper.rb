module ApplicationHelper
  require 'securerandom'

  def grant_access(ward, user)
    if user.grantings.blank?
      return true
    end
    @flag = 1
    for granting in user.grantings
      @accesscontrol = Accesscontrol.where(role_id: granting.role_id).first
      @flag = @flag * @accesscontrol["#{ward}"].to_i
    end
    if @flag == 0
      return false
    else
      return true
    end
  end

  def policy_rule(ward, requester,user)
    if requester.id == user.id
      return true
    end
    @privacypolicy = Privacypolicy.where(user_id: user.id).first
    if !@privacypolicy.blank?
      case @privacypolicy["#{ward}"]
      when 1
        return true
      when 2
        for friendship in user.inverse_friendships
          if friendship.user.id == requester.id
            return true
          end
        end
        return false
      when 3
        return false
      end
    else
      return true
    end
  end

  def policytypes
    @options = [
      [t(:everyone), 1],
      [t(:only_followers) , 2],
      [t(:only_me) , 3]
    ]
    return @options
  end

  def sexs
    @options = [
      [t(:male), t(:male)],
      [t(:female) , t(:female)]
    ]
    return @options
  end

  def controls
    @options = [
      [t(:allow), 1],
      [t(:deny) , 0]
    ]
    return @options
  end

  def sfiletypes
    @options = [
      [t(:video), t(:video)],
      [t(:slide) , t(:slide)],
      [t(:document) , t(:document)]
    ]
    return @options
  end

  def periods
    @options = [
      [t(:fall), t(:fall)],
      [t(:spring), t(:spring)],
      [t(:summer) , t(:summer)]
    ]
    return @options
  end

  def rstatus(s)
    @options = [t(:running),t(:scheduled),t(:stoped),t(:ended), t(:waiting)]
    return @options[s-1]
  end

  def erstatus(s)
    @options = ['running','scheduled','stoped','ended', 'waiting']
    return @options[s-1]
  end

  def status
    @options = [
      [t(:running), 1],
      [t(:scheduled) , 2],
      [t(:stoped) , 3],
      [t(:ended) , 4],
      [t(:waiting) , 5]
    ]
    return @options
  end
  def project_types
    @options = [
      [t(:bonyadi), t(:bonyadi)],
      [t(:karbordi), t(:karbordi)],
      [t(:tosei), t(:tosei)],
      [t(:rahbordi) , t(:rahbordi)]
    ]
    return @options
  end
  def ptypes
    @options = [
      [t(:private), 1],
      [t(:public) , 2]
    ]
    return @options
  end

  def rptypes(p)
    @options = [t(:private),t(:public)]
    return @options[p-1]
  end

  def gtypes
    @options = [
      [t(:open), 1],
      [t(:closed) , 2]
    ]
    return @options
  end

  def rgtypes(g)
    @options = [t(:open),t(:closed)]
    return @options[g-1]
  end

  def itypes
    @options = [
      [t(:need_approval), 1],
      [t(:dont_need_approval) , 2]
    ]
    return @options
  end

  def ritypes(i)
    @options = [t(:need_approval),t(:dont_need_approval)]
    return @options[i-1]
  end

  def grades
    @options = [
      #  [t(:primary), t(:primary)],
      #  [t(:middle) , t(:middle)],
      [t(:high), t(:high)],
      [t(:bs), t(:bs)],
      [t(:ms), t(:ms)],
      [t(:phd), t(:phd)],
      [t(:postdoc), t(:postdoc)]
    ]
    return @options
  end
  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end

  def public?(c)
    if !c.blank?
      if  c.p_type == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def global?(c)
    if !c.blank?
      if  c.g_type == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def admin?(c)
    if !c.blank?
      if c.role == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
