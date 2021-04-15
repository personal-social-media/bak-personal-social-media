import BottomListLink from './bottom-list/link';

export default function NavbarBottomList() {
  return (
    <div className="flex justify-between">
      <BottomListLink icon="fa fa-home fa-2x" url="/"/>
      <BottomListLink icon="fa fa-users fa-2x" url="/"/>
      <BottomListLink icon="fa fa-bell fa-2x" url="/"/>
      <BottomListLink icon="fa fa-bars fa-2x" url="/"/>
    </div>
  );
}
