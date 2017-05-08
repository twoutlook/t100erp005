/* 
================================================================================
檔案代號:nman_t
檔案名稱:網銀資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nman_t
(
nmanent       number(5)      ,/* 企業編碼 */
nman001       varchar2(15)      ,/* 網銀編碼 */
nmanstus       varchar2(1)      ,/* 有效碼 */
nmanownid       varchar2(20)      ,/* 資料所有者 */
nmanowndp       varchar2(10)      ,/* 資料所屬部門 */
nmancrtid       varchar2(20)      ,/* 資料建立者 */
nmancrtdp       varchar2(10)      ,/* 資料建立部門 */
nmancrtdt       timestamp(0)      ,/* 資料創建日 */
nmanmodid       varchar2(20)      ,/* 資料修改者 */
nmanmoddt       timestamp(0)      ,/* 最近修改日 */
nmanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nman_t add constraint nman_pk primary key (nmanent,nman001) enable validate;

create unique index nman_pk on nman_t (nmanent,nman001);

grant select on nman_t to tiptop;
grant update on nman_t to tiptop;
grant delete on nman_t to tiptop;
grant insert on nman_t to tiptop;

exit;
