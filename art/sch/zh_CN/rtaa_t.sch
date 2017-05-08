/* 
================================================================================
檔案代號:rtaa_t
檔案名稱:店群基本資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtaa_t
(
rtaaent       number(5)      ,/* 企業編號 */
rtaaunit       varchar2(10)      ,/* 應用組織 */
rtaa001       varchar2(10)      ,/* 店群編號 */
rtaa002       varchar2(10)      ,/* no use */
rtaa003       varchar2(10)      ,/* 稅區別編號 */
rtaa004       varchar2(10)      ,/* no use */
rtaaownid       varchar2(20)      ,/* 資料所有者 */
rtaaowndp       varchar2(10)      ,/* 資料所屬部門 */
rtaacrtid       varchar2(20)      ,/* 資料建立者 */
rtaacrtdp       varchar2(10)      ,/* 資料建立部門 */
rtaacrtdt       timestamp(0)      ,/* 資料創建日 */
rtaamodid       varchar2(20)      ,/* 資料修改者 */
rtaamoddt       timestamp(0)      ,/* 最近修改日 */
rtaastus       varchar2(10)      /* 狀態碼 */
);
alter table rtaa_t add constraint rtaa_pk primary key (rtaaent,rtaa001) enable validate;

create  index rtaa_01 on rtaa_t (rtaa002);
create unique index rtaa_pk on rtaa_t (rtaaent,rtaa001);

grant select on rtaa_t to tiptop;
grant update on rtaa_t to tiptop;
grant delete on rtaa_t to tiptop;
grant insert on rtaa_t to tiptop;

exit;
