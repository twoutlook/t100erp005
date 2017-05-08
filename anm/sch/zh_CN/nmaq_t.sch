/* 
================================================================================
檔案代號:nmaq_t
檔案名稱:網銀公共配置設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmaq_t
(
nmaqent       number(5)      ,/* 企業編號 */
nmaq001       varchar2(10)      ,/* 接口網銀編號 */
nmaq002       varchar2(10)      ,/* 版本編號 */
nmaq0021       varchar2(10)      ,/* 版本說明 */
nmaq003       varchar2(10)      ,/* 交易類型 */
nmaq004       varchar2(1)      ,/* 報文類型 */
nmaq005       varchar2(1)      ,/* 資料類型 */
nmaq006       varchar2(40)      ,/* 傳輸格式 */
nmaq007       varchar2(1)      ,/* 分隔符號 */
nmaq008       varchar2(1)      ,/* 支付文件分隔符號 */
nmaq009       varchar2(10)      ,/* 支付文件前綴 */
nmaq010       varchar2(1)      ,/* 支付文件編碼方式 */
nmaq011       varchar2(1)      ,/* 支付文件格式 */
nmaq012       varchar2(10)      ,/* 支付文件存放路徑 */
nmaq013       varchar2(1)      ,/* 預設版本 */
nmaqstus       varchar2(1)      ,/* 狀態碼 */
nmaqownid       varchar2(20)      ,/* 資料所有者 */
nmaqowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaqcrtid       varchar2(20)      ,/* 資料建立者 */
nmaqcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaqcrtdt       timestamp(0)      ,/* 資料創建日 */
nmaqmodid       varchar2(20)      ,/* 資料修改者 */
nmaqmoddt       timestamp(0)      ,/* 最近修改日 */
nmaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmaq_t add constraint nmaq_pk primary key (nmaqent,nmaq001,nmaq002,nmaq003,nmaq004,nmaq005) enable validate;

create unique index nmaq_pk on nmaq_t (nmaqent,nmaq001,nmaq002,nmaq003,nmaq004,nmaq005);

grant select on nmaq_t to tiptop;
grant update on nmaq_t to tiptop;
grant delete on nmaq_t to tiptop;
grant insert on nmaq_t to tiptop;

exit;
