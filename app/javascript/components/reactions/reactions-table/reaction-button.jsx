import style from './reaction-button.module.scss';

export default function ReactionButton({children, saveReaction, reactionType, loading}) {
  function createReaction(e, reactionType) {
    e.preventDefault();
    saveReaction(reactionType);
  }
  const className = loading ? style.disabled : '';

  return (
    <button className={className} onClick={(e) => createReaction(e, reactionType)} disabled={loading}>
      {children}
    </button>
  );
}
