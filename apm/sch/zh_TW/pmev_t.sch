/* 
================================================================================
檔案代號:pmev_t
檔案名稱:採購折扣合約單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmev_t
(
pmevent       number(5)      ,/* 企業編號 */
pmevsite       varchar2(10)      ,/* 營運據點 */
pmevdocno       varchar2(20)      ,/* 合約單號 */
pmevdocdt       date      ,/* 單據日期 */
pmev001       varchar2(20)      ,/* 採購人員 */
pmev002       varchar2(10)      ,/* 採購部門 */
pmev003       varchar2(10)      ,/* 帳款供應商 */
pmev004       varchar2(10)      ,/* 幣別 */
pmev005       varchar2(10)      ,/* 稅別 */
pmev006       number(5,2)      ,/* 稅率 */
pmev007       varchar2(10)      ,/* 單價含稅否 */
pmev008       varchar2(10)      ,/* 付款條件 */
pmev009       varchar2(10)      ,/* 交易條件 */
pmev010       varchar2(10)      ,/* 採購通路 */
pmev011       date      ,/* 生效日期 */
pmev012       date      ,/* 失效日期 */
pmev013       varchar2(1)      ,/* 限定幣別 */
pmev014       varchar2(1)      ,/* 限定稅別 */
pmev015       varchar2(1)      ,/* 限定付款條件否 */
pmev016       varchar2(1)      ,/* 限定交易條件否 */
pmev017       varchar2(1)      ,/* 限定採購通路 */
pmev018       varchar2(255)      ,/* 倉退是否納入計算 */
pmev019       varchar2(255)      ,/* 帳款產生方式 */
pmev020       varchar2(10)      ,/* 收款條件 */
pmev030       varchar2(255)      ,/* 備註 */
pmevownid       varchar2(20)      ,/* 資料所有者 */
pmevowndp       varchar2(10)      ,/* 資料所屬部門 */
pmevcrtid       varchar2(20)      ,/* 資料建立者 */
pmevcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmevcrtdt       timestamp(0)      ,/* 資料創建日 */
pmevmodid       varchar2(20)      ,/* 資料修改者 */
pmevmoddt       timestamp(0)      ,/* 最近修改日 */
pmevcnfid       varchar2(20)      ,/* 資料確認者 */
pmevcnfdt       timestamp(0)      ,/* 資料確認日 */
pmevpstid       varchar2(20)      ,/* 資料過帳者 */
pmevpstdt       timestamp(0)      ,/* 資料過帳日 */
pmevstus       varchar2(10)      /* 狀態碼 */
);
alter table pmev_t add constraint pmev_pk primary key (pmevent,pmevdocno) enable validate;

create unique index pmev_pk on pmev_t (pmevent,pmevdocno);

grant select on pmev_t to tiptop;
grant update on pmev_t to tiptop;
grant delete on pmev_t to tiptop;
grant insert on pmev_t to tiptop;

exit;
