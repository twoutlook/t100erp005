/* 
================================================================================
檔案代號:prbc_t
檔案名稱:市場調查計畫明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbc_t
(
prbcent       number(5)      ,/* 企業編號 */
prbcunit       varchar2(10)      ,/* 應用組織 */
prbcsite       varchar2(10)      ,/* 營運據點 */
prbcdocno       varchar2(20)      ,/* 單據編號 */
prbcseq       number(10,0)      ,/* 項次 */
prbc001       varchar2(40)      ,/* 商品編號 */
prbc002       varchar2(40)      ,/* 商品條碼 */
prbc003       varchar2(256)      ,/* 商品特征 */
prbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbc_t add constraint prbc_pk primary key (prbcent,prbcdocno,prbcseq) enable validate;

create unique index prbc_pk on prbc_t (prbcent,prbcdocno,prbcseq);

grant select on prbc_t to tiptop;
grant update on prbc_t to tiptop;
grant delete on prbc_t to tiptop;
grant insert on prbc_t to tiptop;

exit;
