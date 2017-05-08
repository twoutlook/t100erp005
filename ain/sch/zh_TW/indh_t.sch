/* 
================================================================================
檔案代號:indh_t
檔案名稱:報損報溢單單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indh_t
(
indhent       number(5)      ,/* 企業編號 */
indhsite       varchar2(10)      ,/* 營運據點 */
indhunit       varchar2(10)      ,/* 應用組織 */
indhdocno       varchar2(20)      ,/* 單據編號 */
indhseq       number(10,0)      ,/* 項次 */
indh001       varchar2(10)      ,/* 庫區編號 */
indh002       varchar2(40)      ,/* 商品編號 */
indh003       varchar2(40)      ,/* 商品主條碼 */
indh004       varchar2(256)      ,/* 產品特徵 */
indh005       varchar2(10)      ,/* 庫存單位 */
indh006       number(20,6)      ,/* 轉換率 */
indh007       number(20,6)      ,/* 申請數量 */
indh008       number(20,6)      ,/* 核准數量 */
indh009       number(10,0)      ,/* 庫存記賬方向 */
indh010       varchar2(255)      ,/* 備註 */
indhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indh_t add constraint indh_pk primary key (indhent,indhdocno,indhseq) enable validate;

create unique index indh_pk on indh_t (indhent,indhdocno,indhseq);

grant select on indh_t to tiptop;
grant update on indh_t to tiptop;
grant delete on indh_t to tiptop;
grant insert on indh_t to tiptop;

exit;
