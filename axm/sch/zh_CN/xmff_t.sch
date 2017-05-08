/* 
================================================================================
檔案代號:xmff_t
檔案名稱:銷售報價明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmff_t
(
xmffent       number(5)      ,/* 企業編號 */
xmffsite       varchar2(10)      ,/* 營運據點 */
xmffdocno       varchar2(20)      ,/* 報價單號 */
xmffseq       number(10,0)      ,/* 項次 */
xmff001       varchar2(40)      ,/* 料件編號 */
xmff002       varchar2(256)      ,/* 產品特徵 */
xmff003       varchar2(40)      ,/* 客戶料號 */
xmff004       varchar2(10)      ,/* 銷售單位 */
xmff005       varchar2(1)      ,/* 分量計價 */
xmff006       number(20,6)      ,/* 數量 */
xmff007       number(20,6)      ,/* 報價單價 */
xmff008       number(20,6)      ,/* 未稅金額 */
xmff009       number(20,6)      ,/* 含稅金額 */
xmff010       number(20,6)      ,/* 稅額 */
xmff011       number(20,6)      ,/* 標準成本單價 */
xmff012       number(20,6)      ,/* 預估毛利率 */
xmff013       number(20,6)      ,/* 預估毛利金額 */
xmff014       varchar2(255)      ,/* 備註 */
xmffud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmffud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmffud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmffud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmffud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmffud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmffud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmffud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmffud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmffud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmffud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmffud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmffud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmffud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmffud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmffud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmffud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmffud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmffud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmffud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmffud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmffud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmffud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmffud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmffud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmffud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmffud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmffud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmffud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmffud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmff015       varchar2(10)      ,/* 包裝方式 */
xmff016       number(20,6)      ,/* 箱數 */
xmff017       number(20,6)      ,/* 淨重 */
xmff018       number(20,6)      ,/* 毛重 */
xmff019       number(20,6)      /* 材積 */
);
alter table xmff_t add constraint xmff_pk primary key (xmffent,xmffdocno,xmffseq) enable validate;

create unique index xmff_pk on xmff_t (xmffent,xmffdocno,xmffseq);

grant select on xmff_t to tiptop;
grant update on xmff_t to tiptop;
grant delete on xmff_t to tiptop;
grant insert on xmff_t to tiptop;

exit;
