/* 
================================================================================
檔案代號:inbm_t
檔案名稱:裝箱單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inbm_t
(
inbment       number(5)      ,/* 企業編號 */
inbmsite       varchar2(10)      ,/* 營運據點 */
inbmdocno       varchar2(20)      ,/* 單據編號 */
inbmdocdt       date      ,/* 單據日期 */
inbmunit       varchar2(10)      ,/* 配送中心 */
inbm001       varchar2(10)      ,/* 需求對象 */
inbm002       varchar2(20)      ,/* 需求單號 */
inbm003       varchar2(10)      ,/* 來源單據類型 */
inbm004       varchar2(20)      ,/* 來源單號 */
inbm005       varchar2(20)      ,/* 裝箱人員 */
inbm006       varchar2(10)      ,/* 裝箱部門 */
inbm007       varchar2(255)      ,/* 備註 */
inbm008       varchar2(10)      ,/* 需求對象類型 */
inbmstus       varchar2(10)      ,/* 狀態碼 */
inbmownid       varchar2(20)      ,/* 資料所有者 */
inbmowndp       varchar2(10)      ,/* 資料所屬部門 */
inbmcrtid       varchar2(20)      ,/* 資料建立者 */
inbmcrtdp       varchar2(10)      ,/* 資料建立部門 */
inbmcrtdt       timestamp(0)      ,/* 資料創建日 */
inbmmodid       varchar2(20)      ,/* 資料修改者 */
inbmmoddt       timestamp(0)      ,/* 最近修改日 */
inbmcnfid       varchar2(20)      ,/* 資料確認者 */
inbmcnfdt       timestamp(0)      ,/* 資料確認日 */
inbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbm_t add constraint inbm_pk primary key (inbment,inbmdocno) enable validate;

create unique index inbm_pk on inbm_t (inbment,inbmdocno);

grant select on inbm_t to tiptop;
grant update on inbm_t to tiptop;
grant delete on inbm_t to tiptop;
grant insert on inbm_t to tiptop;

exit;
