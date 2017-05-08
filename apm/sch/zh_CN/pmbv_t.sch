/* 
================================================================================
檔案代號:pmbv_t
檔案名稱:採購價格表申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmbv_t
(
pmbvent       number(5)      ,/* 企業編號 */
pmbvdocno       varchar2(20)      ,/* 申請單號 */
pmbvdocdt       date      ,/* 申請日期 */
pmbv001       varchar2(5)      ,/* 採購價格參照表號 */
pmbv002       varchar2(10)      ,/* 基礎幣別 */
pmbv003       varchar2(10)      ,/* 採購分群 */
pmbv004       varchar2(10)      ,/* 申請資料外處理方式 */
pmbv900       varchar2(20)      ,/* 申請人員 */
pmbv901       varchar2(10)      ,/* 申請部門 */
pmbvstus       varchar2(10)      ,/* 資料狀態碼 */
pmbvownid       varchar2(20)      ,/* 資料所有者 */
pmbvowndp       varchar2(10)      ,/* 資料所屬部門 */
pmbvcrtid       varchar2(20)      ,/* 資料建立者 */
pmbvcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmbvcrtdt       timestamp(0)      ,/* 資料創建日 */
pmbvmodid       varchar2(20)      ,/* 資料修改者 */
pmbvmoddt       timestamp(0)      ,/* 最近修改日 */
pmbvcnfid       varchar2(20)      ,/* 資料確認者 */
pmbvcnfdt       timestamp(0)      ,/* 資料確認日 */
pmbvpstid       varchar2(20)      ,/* 資料過帳者 */
pmbvpstdt       timestamp(0)      ,/* 資料過帳日 */
pmbvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbv_t add constraint pmbv_pk primary key (pmbvent,pmbvdocno) enable validate;

create unique index pmbv_pk on pmbv_t (pmbvent,pmbvdocno);

grant select on pmbv_t to tiptop;
grant update on pmbv_t to tiptop;
grant delete on pmbv_t to tiptop;
grant insert on pmbv_t to tiptop;

exit;
