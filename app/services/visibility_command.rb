class VisibilityCommand < BaseCommand
  def keywords
    %i[visibility visibilité]
end

  def perform _bot, event, args
    return unless user = check_user_by_discord_id(event)

    if args.empty?
      event.respond "Ta visibilité actuelle est : #{user.visible}"
      return
    end
    return unless check_fixed_size_args(event, args, %i[boolean])

    user.update(visible: ('true' == args[0].downcase))
    event.respond "Merci ! Ta visibilité est maintenant #{user.visible}"
  end

  def post_register(bot)
    bot.command :visible do |event, *_args|
      perform_complete bot, event, ['true']
    end
    bot.command [:invisible, :unvisible] do |event, *_args|
      perform_complete bot, event, [:false]
    end
  end

  def help_message
    [{ command: keywords.first, args: 'TRUE|FALSE', description: 'Au choix true ou false' },
     { command: 'visible', args: '', description: 'raccourci pour $visibility true' },
     { command: 'unvisible', args: '', description: 'raccourci pour $visibility false' }]
end
end
