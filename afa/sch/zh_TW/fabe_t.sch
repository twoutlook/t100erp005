/* 
================================================================================
檔案代號:fabe_t
檔案名稱:資產變更資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fabe_t
(
fabeent       number(5)      ,/* 企業編號 */
fabe000       varchar2(10)      ,/* 生成批號 */
fabe001       varchar2(10)      ,/* 卡片編號 */
fabe002       number(10)      ,/* 型態 */
fabe003       varchar2(20)      ,/* 財產編號 */
fabe004       varchar2(20)      ,/* 附號 */
fabe005       number(10)      ,/* 資產性質 */
fabe006       varchar2(10)      ,/* 資產主要類型 */
fabe007       varchar2(10)      ,/* 資產次要類型 */
fabe008       varchar2(10)      ,/* 資產組 */
fabe009       varchar2(10)      ,/* 供應廠商 */
fabe010       varchar2(10)      ,/* 製造廠商 */
fabe011       varchar2(40)      ,/* 產地 */
fabe012       varchar2(40)      ,/* 名稱 */
fabe013       varchar2(40)      ,/* 規格型號 */
fabe014       date      ,/* 取得日期 */
fabe015       number(10)      ,/* 資產狀態 */
fabe016       number(10)      ,/* 取得方式 */
fabe017       varchar2(10)      ,/* 單位 */
fabe018       number(20,6)      ,/* 數量 */
fabe019       number(20,6)      ,/* 在外數量 */
fabe020       varchar2(10)      ,/* 幣別 */
fabe021       number(20,6)      ,/* 原幣單價 */
fabe022       number(20,6)      ,/* 原幣金額 */
fabe023       number(20,6)      ,/* 本幣單價 */
fabe024       number(20,6)      ,/* 本幣金額 */
fabe025       varchar2(20)      ,/* 保管人員 */
fabe026       varchar2(10)      ,/* 保管部門 */
fabe027       varchar2(10)      ,/* 存放位置 */
fabe028       varchar2(10)      ,/* 存放組織 */
fabe029       varchar2(20)      ,/* 負責人員 */
fabe030       varchar2(10)      ,/* 管理組織 */
fabe031       varchar2(10)      ,/* 核算組織 */
fabe032       varchar2(10)      ,/* 歸屬法人 */
fabe033       varchar2(1)      ,/* 直接資本化 */
fabe034       number(10)      ,/* 保稅 */
fabe035       number(10)      ,/* 保險 */
fabe036       number(10)      ,/* 免稅 */
fabe037       number(10)      ,/* 抵押 */
fabe038       varchar2(20)      ,/* 採購單號 */
fabe039       varchar2(20)      ,/* 收貨單號 */
fabe040       varchar2(20)      ,/* 賬款單號 */
fabe041       varchar2(10)      ,/* 來源營運中心 */
fabe042       number(10)      ,/* 資產屬性 */
fabe043       number(15,3)      ,/* 預計總工作量 */
fabe044       number(15,3)      ,/* 已使用工作量 */
fabe045       number(10,0)      ,/* 版次 */
fabeownid       varchar2(20)      ,/* 資料所有者 */
fabeowndp       varchar2(10)      ,/* 資料所屬部門 */
fabecrtid       varchar2(20)      ,/* 資料建立者 */
fabecrtdp       varchar2(10)      ,/* 資料建立部門 */
fabecrtdt       timestamp(0)      ,/* 資料創建日 */
fabemodid       varchar2(20)      ,/* 資料修改者 */
fabemoddt       timestamp(0)      ,/* 最近修改日 */
fabestus       varchar2(10)      ,/* 狀態碼 */
fabe046       varchar2(255)      ,/* 備註 */
fabeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabe_t add constraint fabe_pk primary key (fabeent,fabe000,fabe001,fabe003,fabe004,fabe045) enable validate;

create unique index fabe_pk on fabe_t (fabeent,fabe000,fabe001,fabe003,fabe004,fabe045);

grant select on fabe_t to tiptop;
grant update on fabe_t to tiptop;
grant delete on fabe_t to tiptop;
grant insert on fabe_t to tiptop;

exit;
