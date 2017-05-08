/* 
================================================================================
檔案代號:pmau_t
檔案名稱:彈性採購價格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmau_t
(
pmauent       number(5)      ,/* 企業編號 */
pmau001       varchar2(5)      ,/* 採購價格參照表號 */
pmau002       varchar2(10)      ,/* 採購控制組 */
pmau003       varchar2(10)      ,/* 幣別編號 */
pmau005       varchar2(10)      ,/* 採購通路 */
pmau006       varchar2(20)      ,/* 作業編號 */
pmau011       varchar2(40)      ,/* 料件編號 */
pmau012       varchar2(256)      ,/* 產品特徵 */
pmau013       varchar2(10)      ,/* 洲別編號 */
pmau014       varchar2(10)      ,/* 國家編號 */
pmau015       varchar2(10)      ,/* 州省編號 */
pmau016       varchar2(10)      ,/* 供應商價格群組 */
pmau017       varchar2(10)      ,/* 供應商分類 */
pmau018       varchar2(10)      ,/* 計價單位 */
pmau019       varchar2(10)      ,/* 稅別編號 */
pmau020       varchar2(10)      ,/* 付款條件 */
pmau021       varchar2(10)      ,/* 交易條件 */
pmau022       number(20,6)      ,/* 單價 */
pmau100       varchar2(20)      ,/* 申請單號 */
pmaustus       varchar2(10)      ,/* 資料狀態碼 */
pmauownid       varchar2(20)      ,/* 資料所有者 */
pmauowndp       varchar2(10)      ,/* 資料所屬部門 */
pmaucrtid       varchar2(20)      ,/* 資料建立者 */
pmaucrtdp       varchar2(10)      ,/* 資料建立部門 */
pmaucrtdt       timestamp(0)      ,/* 資料創建日 */
pmaumodid       varchar2(20)      ,/* 資料修改者 */
pmaumoddt       timestamp(0)      ,/* 最近修改日 */
pmauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmauud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmau031       varchar2(10)      ,/* 系列 */
pmau032       varchar2(10)      /* 產品分類 */
);
alter table pmau_t add constraint pmau_pk primary key (pmauent,pmau001,pmau002,pmau003,pmau005,pmau006,pmau011,pmau012,pmau013,pmau014,pmau015,pmau016,pmau017,pmau018,pmau019,pmau020,pmau021,pmau031,pmau032) enable validate;

create  index pmau_01 on pmau_t (pmau100);
create unique index pmau_pk on pmau_t (pmauent,pmau001,pmau002,pmau003,pmau005,pmau006,pmau011,pmau012,pmau013,pmau014,pmau015,pmau016,pmau017,pmau018,pmau019,pmau020,pmau021,pmau031,pmau03);

grant select on pmau_t to tiptop;
grant update on pmau_t to tiptop;
grant delete on pmau_t to tiptop;
grant insert on pmau_t to tiptop;

exit;
