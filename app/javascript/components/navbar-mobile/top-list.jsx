import TopListLink from './top-list/link';

export default function NavbarMobileTopList() {
  return (
    <div className="text-gray-700 hover:text-gray-900 flex">
      <TopListLink url="/search" className="mx-2">
        <div className="text-2xl">
          <i className="fa fa-search"/>
        </div>
      </TopListLink>
      <TopListLink url="/search" className="mx-2">
        <div className="text-2xl">
          <i className="fa fa-envelope-square"/>
        </div>
      </TopListLink>
    </div>
  );
}
