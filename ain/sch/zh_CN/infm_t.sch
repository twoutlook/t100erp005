/* 
================================================================================
檔案代號:infm_t
檔案名稱:隨貨同行單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table infm_t
(
infment       number(5)      ,/* 企業編號 */
infmsite       varchar2(10)      ,/* 營運據點 */
infmunit       varchar2(10)      ,/* 應用組織 */
infmdocno       varchar2(20)      ,/* 隨貨同行單號 */
infmdocdt       date      ,/* 單據日期 */
infm001       varchar2(20)      ,/* 製單人員 */
infm002       varchar2(10)      ,/* 製單部門 */
infm003       varchar2(10)      ,/* 撥出營運據點 */
infm004       varchar2(10)      ,/* 撥入營運組織 */
infm005       varchar2(20)      ,/* 撥入確認人員 */
infm006       date      ,/* 撥入確認日期 */
infm007       varchar2(255)      ,/* 備註 */
infmstus       varchar2(10)      ,/* 狀態碼 */
infmownid       varchar2(20)      ,/* 資料所有者 */
infmowndp       varchar2(10)      ,/* 資料所屬部門 */
infmcrtid       varchar2(20)      ,/* 資料建立者 */
infmcrtdp       varchar2(10)      ,/* 資料建立部門 */
infmcrtdt       timestamp(0)      ,/* 資料創建日 */
infmmodid       varchar2(20)      ,/* 資料修改者 */
infmmoddt       timestamp(0)      ,/* 最近修改日 */
infmcnfid       varchar2(20)      ,/* 資料確認者 */
infmcnfdt       timestamp(0)      ,/* 資料確認日 */
infmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infm_t add constraint infm_pk primary key (infment,infmdocno) enable validate;

create unique index infm_pk on infm_t (infment,infmdocno);

grant select on infm_t to tiptop;
grant update on infm_t to tiptop;
grant delete on infm_t to tiptop;
grant insert on infm_t to tiptop;

exit;
