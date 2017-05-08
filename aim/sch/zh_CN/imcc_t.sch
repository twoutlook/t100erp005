/* 
================================================================================
檔案代號:imcc_t
檔案名稱:料件據點庫存分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imcc_t
(
imccent       number(5)      ,/* 企業編號 */
imccownid       varchar2(20)      ,/* 資料所有者 */
imccowndp       varchar2(10)      ,/* 資料所屬部門 */
imcccrtid       varchar2(20)      ,/* 資料建立者 */
imcccrtdp       varchar2(10)      ,/* 資料建立部門 */
imcccrtdt       timestamp(0)      ,/* 資料創建日 */
imccmodid       varchar2(20)      ,/* 資料修改者 */
imccmoddt       timestamp(0)      ,/* 最近修改日 */
imccstus       varchar2(10)      ,/* 狀態碼 */
imcc051       varchar2(10)      ,/* 庫存分群 */
imcc052       varchar2(20)      ,/* 倉管員 */
imcc053       varchar2(10)      ,/* 據點庫存單位 */
imcc054       varchar2(1)      ,/* 庫存多單位 */
imcc055       varchar2(10)      ,/* 庫存管理特微 */
imcc056       varchar2(1)      ,/* 庫存管理特徵可空白 */
imcc057       varchar2(10)      ,/* ABC碼 */
imcc058       varchar2(10)      ,/* 存貨備置策略 */
imcc059       varchar2(10)      ,/* 撿貨策略 */
imcc061       varchar2(10)      ,/* 庫存批號控管方式 */
imcc062       varchar2(1)      ,/* 庫存批號自動編碼否 */
imcc063       varchar2(10)      ,/* 庫存批號編碼方式 */
imcc064       varchar2(10)      ,/* 庫存批號唯一性檢查控管 */
imcc071       varchar2(10)      ,/* 製造批號控管方式 */
imcc072       varchar2(1)      ,/* 製造批號自動編碼否 */
imcc073       varchar2(10)      ,/* 製造批號編碼方式 */
imcc074       varchar2(10)      ,/* 製造批號唯一性檢查控管 */
imcc081       varchar2(10)      ,/* 序號控管方式 */
imcc082       varchar2(1)      ,/* 序號自動編碼否 */
imcc083       varchar2(10)      ,/* 序號編碼方式 */
imcc084       varchar2(10)      ,/* 序號唯一性檢查控管 */
imcc091       varchar2(10)      ,/* 預設庫位 */
imcc092       varchar2(10)      ,/* 預設儲位 */
imcc093       varchar2(1)      ,/* 箱盒號條碼管理 */
imcc094       number(20,6)      ,/* 盤點容差數 */
imcc095       number(20,6)      ,/* 盤點容差率 */
imccsite       varchar2(10)      ,/* 營運據點 */
imcc097       varchar2(10)      ,/* no use */
imcc101       number(20,6)      ,/* 調撥批量 */
imcc102       number(20,6)      ,/* 調撥最小數量 */
imcc096       date      ,/* 呆滯日期開帳 */
imccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcc_t add constraint imcc_pk primary key (imccent,imcc051,imccsite) enable validate;

create unique index imcc_pk on imcc_t (imccent,imcc051,imccsite);

grant select on imcc_t to tiptop;
grant update on imcc_t to tiptop;
grant delete on imcc_t to tiptop;
grant insert on imcc_t to tiptop;

exit;
