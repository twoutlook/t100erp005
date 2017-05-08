/* 
================================================================================
檔案代號:nmbm_t
檔案名稱:內部資金排程主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmbm_t
(
nmbment       number(5)      ,/* 企業編碼 */
nmbmdocno       varchar2(20)      ,/* 調度單號 */
nmbmdocdt       date      ,/* 申請日期 */
nmbm001       varchar2(10)      ,/* 結算中心 */
nmbmstus       varchar2(1)      ,/* 狀態碼 */
nmbmownid       varchar2(20)      ,/* 資料所有者 */
nmbmowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbmcrtid       varchar2(20)      ,/* 資料建立者 */
nmbmcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbmcrtdt       timestamp(0)      ,/* 資料創建日 */
nmbmmodid       varchar2(20)      ,/* 資料修改者 */
nmbmmoddt       timestamp(0)      ,/* 最近修改日 */
nmbmcnfid       varchar2(20)      ,/* 資料確認者 */
nmbmcnfdt       timestamp(0)      ,/* 資料確認日 */
nmbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbm_t add constraint nmbm_pk primary key (nmbment,nmbmdocno) enable validate;

create unique index nmbm_pk on nmbm_t (nmbment,nmbmdocno);

grant select on nmbm_t to tiptop;
grant update on nmbm_t to tiptop;
grant delete on nmbm_t to tiptop;
grant insert on nmbm_t to tiptop;

exit;
