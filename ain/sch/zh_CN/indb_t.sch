/* 
================================================================================
檔案代號:indb_t
檔案名稱:調撥申請單單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indb_t
(
indbent       number(5)      ,/* 企業編號 */
indbsite       varchar2(10)      ,/* 營運據點 */
indbunit       varchar2(10)      ,/* 應用組織 */
indbdocno       varchar2(20)      ,/* 單號 */
indbseq       number(10,0)      ,/* 項次 */
indb001       varchar2(40)      ,/* 商品編號 */
indb002       varchar2(40)      ,/* 商品條碼 */
indb003       varchar2(256)      ,/* 產品特徵 */
indb004       varchar2(10)      ,/* 庫存單位 */
indb005       varchar2(10)      ,/* 包裝單位 */
indb006       number(20,6)      ,/* 件裝數 */
indb007       number(20,6)      ,/* 調撥申請件數 */
indb008       number(20,6)      ,/* 調撥申請數量 */
indb009       number(20,6)      ,/* 核准件數 */
indb010       number(20,6)      ,/* 核准數量 */
indb011       number(20,6)      ,/* 撥出數量 */
indb012       number(20,6)      ,/* 撥入數量 */
indb013       varchar2(255)      ,/* 備註 */
indb101       varchar2(20)      ,/* 限定庫存管理特徵 */
indb102       varchar2(10)      ,/* 限定撥出庫位 */
indb103       varchar2(10)      ,/* 限定撥出儲位 */
indb104       varchar2(30)      ,/* 限定撥出批號 */
indb105       varchar2(10)      ,/* 參考單位 */
indb106       number(20,6)      ,/* 參考數量 */
indb107       varchar2(10)      ,/* 撥入庫位 */
indb108       varchar2(10)      ,/* 撥入儲位 */
indb151       varchar2(10)      ,/* 理由碼 */
indbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
indb014       varchar2(10)      ,/* 撥入單位 */
indb015       varchar2(20)      ,/* 專案編號 */
indb016       varchar2(30)      ,/* WBS */
indb017       varchar2(30)      /* 活動編號 */
);
alter table indb_t add constraint indb_pk primary key (indbent,indbdocno,indbseq) enable validate;

create unique index indb_pk on indb_t (indbent,indbdocno,indbseq);

grant select on indb_t to tiptop;
grant update on indb_t to tiptop;
grant delete on indb_t to tiptop;
grant insert on indb_t to tiptop;

exit;
