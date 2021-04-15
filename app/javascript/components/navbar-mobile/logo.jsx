export default function NavbarLogo({logoUrl}) {
  return (
    <div className="flex items-center select-none">
      <img src={logoUrl} alt="logo" className="h-16 w-16"/>
      <span className="text-gray-700 hover:text-gray-900">Personal Social Media</span>
    </div>
  );
}
