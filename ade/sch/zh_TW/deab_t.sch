/* 
================================================================================
檔案代號:deab_t
檔案名稱:門店營業款轉備用金單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deab_t
(
deabent       number(5)      ,/* 企業編號 */
deabsite       varchar2(10)      ,/* 營運據點 */
deabunit       varchar2(10)      ,/* 應用組織 */
deabdocno       varchar2(20)      ,/* 單據編號 */
deabdocdt       date      ,/* 單據日期 */
deab001       date      ,/* 營業日期 */
deab002       varchar2(20)      ,/* 存繳人員 */
deabstus       varchar2(10)      ,/* 狀態碼 */
deabownid       varchar2(20)      ,/* 資料所有者 */
deabowndp       varchar2(10)      ,/* 資料所屬部門 */
deabcrtid       varchar2(20)      ,/* 資料建立者 */
deabcrtdp       varchar2(10)      ,/* 資料建立部門 */
deabcrtdt       timestamp(0)      ,/* 資料創建日 */
deabmodid       varchar2(20)      ,/* 資料修改者 */
deabmoddt       timestamp(0)      ,/* 最近修改日 */
deabcnfid       varchar2(20)      ,/* 資料確認者 */
deabcnfdt       timestamp(0)      ,/* 資料確認日 */
deabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deab_t add constraint deab_pk primary key (deabent,deabdocno) enable validate;

create unique index deab_pk on deab_t (deabent,deabdocno);

grant select on deab_t to tiptop;
grant update on deab_t to tiptop;
grant delete on deab_t to tiptop;
grant insert on deab_t to tiptop;

exit;
