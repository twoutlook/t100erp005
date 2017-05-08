/* 
================================================================================
檔案代號:mmbm_t
檔案名稱:會員卡續期異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbm_t
(
mmbment       number(5)      ,/* 企業編號 */
mmbmsite       varchar2(10)      ,/* 營運據點 */
mmbmunit       varchar2(10)      ,/* 應用組織 */
mmbmdocno       varchar2(20)      ,/* 單號 */
mmbmdocdt       date      ,/* 單據日期 */
mmbm001       varchar2(10)      ,/* 異動來源 */
mmbm002       varchar2(10)      ,/* 理由碼 */
mmbm003       varchar2(1)      ,/* 自動續期 */
mmbm004       varchar2(10)      ,/* 申請組織 */
mmbmstus       varchar2(10)      ,/* 狀態碼 */
mmbmownid       varchar2(20)      ,/* 資料所有者 */
mmbmowndp       varchar2(10)      ,/* 資料所屬部門 */
mmbmcrtid       varchar2(20)      ,/* 資料建立者 */
mmbmcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbmcrtdt       timestamp(0)      ,/* 資料創建日 */
mmbmmodid       varchar2(20)      ,/* 資料修改者 */
mmbmmoddt       timestamp(0)      ,/* 最近修改日 */
mmbmcnfid       varchar2(20)      ,/* 資料確認者 */
mmbmcnfdt       timestamp(0)      ,/* 資料確認日 */
mmbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbm_t add constraint mmbm_pk primary key (mmbment,mmbmdocno) enable validate;

create unique index mmbm_pk on mmbm_t (mmbment,mmbmdocno);

grant select on mmbm_t to tiptop;
grant update on mmbm_t to tiptop;
grant delete on mmbm_t to tiptop;
grant insert on mmbm_t to tiptop;

exit;
