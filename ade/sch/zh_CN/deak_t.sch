/* 
================================================================================
檔案代號:deak_t
檔案名稱:門店營業款銀行存繳單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deak_t
(
deakent       number(5)      ,/* 企業編號 */
deaksite       varchar2(10)      ,/* 營運據點 */
deakunit       varchar2(10)      ,/* 應用組織 */
deakdocno       varchar2(20)      ,/* 單據編號 */
deakdocdt       date      ,/* 單據日期 */
deak001       varchar2(15)      ,/* 銀行編號 */
deak002       varchar2(20)      ,/* 存繳人員 */
deakownid       varchar2(20)      ,/* 資料所有者 */
deakowndp       varchar2(10)      ,/* 資料所屬部門 */
deakcrtid       varchar2(20)      ,/* 資料建立者 */
deakcrtdp       varchar2(10)      ,/* 資料建立部門 */
deakcrtdt       timestamp(0)      ,/* 資料創建日 */
deakmodid       varchar2(20)      ,/* 資料修改者 */
deakmoddt       timestamp(0)      ,/* 最近修改日 */
deakstus       varchar2(10)      ,/* 狀態碼 */
deakcnfid       varchar2(20)      ,/* 資料確認者 */
deakcnfdt       timestamp(0)      ,/* 資料確認日 */
deakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deak_t add constraint deak_pk primary key (deakent,deakdocno) enable validate;

create unique index deak_pk on deak_t (deakent,deakdocno);

grant select on deak_t to tiptop;
grant update on deak_t to tiptop;
grant delete on deak_t to tiptop;
grant insert on deak_t to tiptop;

exit;
