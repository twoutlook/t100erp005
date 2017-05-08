/* 
================================================================================
檔案代號:xmbv_t
檔案名稱:銷售價格表申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmbv_t
(
xmbvent       number(5)      ,/* 企業編號 */
xmbvdocno       varchar2(20)      ,/* 申請單號 */
xmbvdocdt       date      ,/* 申請日期 */
xmbv001       varchar2(5)      ,/* 銷售價格參照表號 */
xmbv002       varchar2(10)      ,/* 基礎幣別 */
xmbv003       varchar2(10)      ,/* 銷售分群 */
xmbv004       varchar2(10)      ,/* 申請資料外處理方式 */
xmbv900       varchar2(20)      ,/* 申請人員 */
xmbv901       varchar2(10)      ,/* 申請部門 */
xmbvstus       varchar2(10)      ,/* 資料狀態碼 */
xmbvownid       varchar2(20)      ,/* 資料所有者 */
xmbvowndp       varchar2(10)      ,/* 資料所屬部門 */
xmbvcrtid       varchar2(20)      ,/* 資料建立者 */
xmbvcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmbvcrtdt       timestamp(0)      ,/* 資料創建日 */
xmbvmodid       varchar2(20)      ,/* 資料修改者 */
xmbvmoddt       timestamp(0)      ,/* 最近修改日 */
xmbvcnfid       varchar2(20)      ,/* 資料確認者 */
xmbvcnfdt       timestamp(0)      ,/* 資料確認日 */
xmbvpstid       varchar2(20)      ,/* 資料過帳者 */
xmbvpstdt       timestamp(0)      ,/* 資料過帳日 */
xmbvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmbvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmbvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmbvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmbvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmbvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmbvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmbvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmbvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmbvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmbvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmbvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmbvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmbvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmbvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmbvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmbvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmbvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmbvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmbvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmbvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmbvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmbvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmbvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmbvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmbvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmbvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmbvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmbvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmbvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmbv_t add constraint xmbv_pk primary key (xmbvent,xmbvdocno) enable validate;

create unique index xmbv_pk on xmbv_t (xmbvent,xmbvdocno);

grant select on xmbv_t to tiptop;
grant update on xmbv_t to tiptop;
grant delete on xmbv_t to tiptop;
grant insert on xmbv_t to tiptop;

exit;
