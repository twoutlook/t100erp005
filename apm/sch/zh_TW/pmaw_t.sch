/* 
================================================================================
檔案代號:pmaw_t
檔案名稱:採購價格表檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmaw_t
(
pmawent       number(5)      ,/* 企業編號 */
pmaw001       varchar2(5)      ,/* 採購價格參照表號 */
pmaw002       varchar2(10)      ,/* 基礎幣別 */
pmaw011       varchar2(40)      ,/* 料件編號 */
pmaw012       varchar2(256)      ,/* 產品特徵 */
pmaw013       varchar2(10)      ,/* 計價單位 */
pmaw014       varchar2(1)      ,/* 參考資料否 */
pmaw015       varchar2(40)      ,/* 參考料號 */
pmaw016       varchar2(256)      ,/* 參考料號產品特徵 */
pmaw017       number(20,6)      ,/* 加金額 */
pmaw018       number(20,6)      ,/* 加百分比 */
pmaw019       number(20,6)      ,/* 標準定價 */
pmaw020       number(20,6)      ,/* 一般採購價 */
pmaw021       number(20,6)      ,/* 警告容差率 */
pmaw022       number(20,6)      ,/* 拒絕容差率 */
pmaw100       varchar2(20)      ,/* 申請單號 */
pmawstus       varchar2(10)      ,/* 資料狀態碼 */
pmawownid       varchar2(20)      ,/* 資料所有者 */
pmawowndp       varchar2(10)      ,/* 資料所屬部門 */
pmawcrtid       varchar2(20)      ,/* 資料建立者 */
pmawcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmawcrtdt       timestamp(0)      ,/* 資料創建日 */
pmawmodid       varchar2(20)      ,/* 資料修改者 */
pmawmoddt       timestamp(0)      ,/* 最近修改日 */
pmawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmawud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmaw031       varchar2(10)      ,/* 系列 */
pmaw032       varchar2(10)      ,/* 產品分類 */
pmaw033       varchar2(10)      ,/* 參考系列 */
pmaw034       varchar2(10)      /* 參考產品分類 */
);
alter table pmaw_t add constraint pmaw_pk primary key (pmawent,pmaw001,pmaw002,pmaw011,pmaw012,pmaw013,pmaw031,pmaw032) enable validate;

create unique index pmaw_pk on pmaw_t (pmawent,pmaw001,pmaw002,pmaw011,pmaw012,pmaw013,pmaw031,pmaw032);

grant select on pmaw_t to tiptop;
grant update on pmaw_t to tiptop;
grant delete on pmaw_t to tiptop;
grant insert on pmaw_t to tiptop;

exit;
