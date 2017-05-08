/* 
================================================================================
檔案代號:imbh_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imbh_t
(
imbhent       number(5)      ,/* 企業編號 */
imbhsite       varchar2(10)      ,/* 營運據點 */
imbh001       varchar2(40)      ,/* 料件編號 */
imbh011       varchar2(10)      ,/* 稅別 */
imbh012       varchar2(10)      ,/* 稅則編號 */
imbh013       number(20,6)      ,/* 保稅年度盤差容許率 */
imbh014       varchar2(10)      ,/* 保稅統計類別 */
imbh015       varchar2(10)      ,/* 保稅群組代碼 */
imbh016       number(20,6)      ,/* 保稅應補稅稅率 */
imbh017       number(20,6)      ,/* 保稅單價 */
imbh018       varchar2(10)      ,/* 保稅料件型態 */
imbh019       varchar2(30)      ,/* 帳號編號 */
imbhdocno       varchar2(20)      ,/* 申請單號 */
imbhownid       varchar2(20)      ,/* 資料所有者 */
imbhowndp       varchar2(10)      ,/* 資料所屬部門 */
imbhcrtid       varchar2(20)      ,/* 資料建立者 */
imbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
imbhcrtdt       timestamp(0)      ,/* 資料創建日 */
imbhmodid       varchar2(20)      ,/* 資料修改者 */
imbhmoddt       timestamp(0)      ,/* 最近修改日 */
imbhcnfid       varchar2(20)      ,/* 資料確認者 */
imbhcnfdt       timestamp(0)      ,/* 資料確認日 */
imbhpstid       varchar2(20)      ,/* 資料過帳者 */
imbhpstdt       timestamp(0)      ,/* 資料過帳日 */
imbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbh_t add constraint imbh_pk primary key (imbhent,imbhsite,imbhdocno) enable validate;

create  index imbh_01 on imbh_t (imbh001);
create  index imbh_02 on imbh_t (imbh011);
create unique index imbh_pk on imbh_t (imbhent,imbhsite,imbhdocno);

grant select on imbh_t to tiptop;
grant update on imbh_t to tiptop;
grant delete on imbh_t to tiptop;
grant insert on imbh_t to tiptop;

exit;
