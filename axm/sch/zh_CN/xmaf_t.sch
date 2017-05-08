/* 
================================================================================
檔案代號:xmaf_t
檔案名稱:客戶料件預設條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmaf_t
(
xmafent       number(5)      ,/* 企業編號 */
xmafsite       varchar2(10)      ,/* 營運據點 */
xmaf001       varchar2(10)      ,/* 客戶編號 */
xmaf002       varchar2(10)      ,/* 控制組 */
xmaf003       varchar2(40)      ,/* 料件編號 */
xmaf004       varchar2(256)      ,/* 產品特徵 */
xmaf005       varchar2(40)      ,/* 包裝容器 */
xmaf006       varchar2(10)      ,/* 銷售單位 */
xmaf007       varchar2(10)      ,/* 參考單位 */
xmaf008       varchar2(10)      ,/* 計價單位 */
xmaf009       varchar2(10)      ,/* 出貨營運據點 */
xmaf010       varchar2(10)      ,/* 出貨庫位 */
xmaf011       varchar2(10)      ,/* 出貨儲位 */
xmaf012       varchar2(4000)      ,/* 收貨地址 */
xmaf013       number(5,0)      ,/* 提前出貨天數 */
xmaf014       varchar2(10)      ,/* 交運方式 */
xmaf015       varchar2(255)      ,/* 額外品明規格說明 */
xmafownid       varchar2(20)      ,/* 資料所有者 */
xmafowndp       varchar2(10)      ,/* 資料所屬部門 */
xmafcrtid       varchar2(20)      ,/* 資料建立者 */
xmafcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmafcrtdt       timestamp(0)      ,/* 資料創建日 */
xmafmodid       varchar2(20)      ,/* 資料修改者 */
xmafmoddt       timestamp(0)      ,/* 最近修改日 */
xmafstus       varchar2(10)      ,/* 狀態碼 */
xmafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmaf_t add constraint xmaf_pk primary key (xmafent,xmafsite,xmaf001,xmaf002,xmaf003,xmaf004) enable validate;

create unique index xmaf_pk on xmaf_t (xmafent,xmafsite,xmaf001,xmaf002,xmaf003,xmaf004);

grant select on xmaf_t to tiptop;
grant update on xmaf_t to tiptop;
grant delete on xmaf_t to tiptop;
grant insert on xmaf_t to tiptop;

exit;
