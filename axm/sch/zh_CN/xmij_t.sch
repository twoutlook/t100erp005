/* 
================================================================================
檔案代號:xmij_t
檔案名稱:銷售組織資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmij_t
(
xmijent       number(5)      ,/* 企業編號 */
xmij001       varchar2(10)      ,/* 銷售組織 */
xmij002       varchar2(1)      ,/* 預測點 */
xmij003       varchar2(1)      ,/* 匯總點 */
xmij004       varchar2(1)      ,/* 匯總維度-營運據點 */
xmij005       varchar2(1)      ,/* 匯總維度-銷售組織 */
xmij006       varchar2(1)      ,/* 匯總維度-客戶 */
xmij007       varchar2(1)      ,/* 匯總維度-通路 */
xmij008       varchar2(1)      ,/* 匯總維度-業務員 */
xmij009       varchar2(1)      ,/* 匯總維度-產品分類 */
xmij010       varchar2(1)      ,/* 匯總維度-預測料號 */
xmij011       varchar2(1)      ,/* 產匯總維度-品特徵 */
xmijownid       varchar2(20)      ,/* 資料所有者 */
xmijowndp       varchar2(10)      ,/* 資料所屬部門 */
xmijcrtid       varchar2(20)      ,/* 資料建立者 */
xmijcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmijcrtdt       timestamp(0)      ,/* 資料創建日 */
xmijmodid       varchar2(20)      ,/* 資料修改者 */
xmijmoddt       timestamp(0)      ,/* 最近修改日 */
xmijstus       varchar2(10)      ,/* 狀態碼 */
xmijud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmijud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmijud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmijud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmijud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmijud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmijud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmijud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmijud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmijud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmijud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmijud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmijud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmijud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmijud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmijud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmijud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmijud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmijud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmijud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmijud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmijud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmijud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmijud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmijud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmijud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmijud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmijud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmijud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmijud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmij_t add constraint xmij_pk primary key (xmijent,xmij001) enable validate;

create unique index xmij_pk on xmij_t (xmijent,xmij001);

grant select on xmij_t to tiptop;
grant update on xmij_t to tiptop;
grant delete on xmij_t to tiptop;
grant insert on xmij_t to tiptop;

exit;
