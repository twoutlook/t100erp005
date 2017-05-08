/* 
================================================================================
檔案代號:xcao_t
檔案名稱:成本差異分攤依據單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcao_t
(
xcaoent       number(5)      ,/* 企業編號 */
xcaold       varchar2(5)      ,/* 帳別編號 */
xcao001       varchar2(80)      ,/* 分攤公式類型 */
xcao002       varchar2(1)      ,/* 分攤依據維度 */
xcaoownid       varchar2(20)      ,/* 資料所有者 */
xcaoowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaocrtid       varchar2(20)      ,/* 資料建立者 */
xcaocrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaocrtdt       timestamp(0)      ,/* 資料創建日 */
xcaomodid       varchar2(20)      ,/* 資料修改者 */
xcaomoddt       timestamp(0)      ,/* 最近修改日 */
xcaostus       varchar2(10)      /* 狀態碼 */
);
alter table xcao_t add constraint xcao_pk primary key (xcaoent,xcaold,xcao001) enable validate;

create unique index xcao_pk on xcao_t (xcaoent,xcaold,xcao001);

grant select on xcao_t to tiptop;
grant update on xcao_t to tiptop;
grant delete on xcao_t to tiptop;
grant insert on xcao_t to tiptop;

exit;
