/* 
================================================================================
檔案代號:faak_t
檔案名稱:固定資產底稿資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faak_t
(
faakent       number(5)      ,/* 企業編號 */
faakld       varchar2(5)      ,/* 帳套別編碼 */
faak000       varchar2(10)      ,/* 產生批號 */
faak001       varchar2(10)      ,/* 卡片編號 */
faak002       number(10)      ,/* 型態 */
faak003       varchar2(20)      ,/* 底稿編號 */
faak004       varchar2(20)      ,/* 附號 */
faak005       number(10)      ,/* 資產性質 */
faak006       varchar2(10)      ,/* 資產主要類型 */
faak007       varchar2(10)      ,/* 資產次要類型 */
faak008       varchar2(10)      ,/* 資產組 */
faak009       varchar2(10)      ,/* 供應廠商 */
faak010       varchar2(10)      ,/* 製造廠商 */
faak011       varchar2(40)      ,/* 產地 */
faak012       varchar2(40)      ,/* 名稱 */
faak013       varchar2(40)      ,/* 規格型號 */
faak014       date      ,/* 取得日期 */
faak015       number(10)      ,/* 資產狀態 */
faak016       number(10)      ,/* 取得方式 */
faak017       varchar2(10)      ,/* 單位 */
faak018       number(20,6)      ,/* 數量 */
faak019       varchar2(10)      ,/* 幣別 */
faak020       number(20,10)      ,/* 匯率 */
faak021       number(20,6)      ,/* 原幣單價 */
faak022       number(20,6)      ,/* 原幣金額 */
faak023       number(20,6)      ,/* 本幣單價 */
faak024       number(20,6)      ,/* 本幣金額 */
faak025       varchar2(20)      ,/* 保管人員 */
faak026       varchar2(10)      ,/* 保管部門 */
faak027       varchar2(10)      ,/* 存放位置 */
faak028       varchar2(10)      ,/* 存放組織 */
faak029       varchar2(20)      ,/* 負責人員 */
faak030       varchar2(10)      ,/* 管理組織 */
faak031       varchar2(10)      ,/* 核算組織 */
faak032       varchar2(10)      ,/* 歸屬法人 */
faak033       varchar2(1)      ,/* 直接資本化 */
faak034       date      ,/* 入帳日期 */
faak035       number(10)      ,/* 保稅 */
faak036       number(10)      ,/* 保險 */
faak037       number(10)      ,/* 免稅 */
faak038       number(10)      ,/* 抵押 */
faak039       varchar2(20)      ,/* 採購單號 */
faak040       varchar2(20)      ,/* 收貨單號 */
faak041       varchar2(20)      ,/* 帳款單號 */
faak042       varchar2(10)      ,/* 來源營運中心 */
faak043       varchar2(1)      ,/* 更新碼 */
faak044       number(10,0)      ,/* 帳款編號項次 */
faak045       number(10,0)      ,/* 雜發單號項次 */
faak046       varchar2(20)      ,/* 資產來源 */
faak047       varchar2(20)      ,/* 雜發單號 */
faak048       varchar2(20)      ,/* 傳票單號 */
faak049       number(10)      ,/* 資產屬性 */
faak050       varchar2(20)      ,/* 項目編號 */
faak051       varchar2(30)      ,/* WBS */
faakownid       varchar2(20)      ,/* 資料所有者 */
faakowndp       varchar2(10)      ,/* 資料所屬部門 */
faakcrtid       varchar2(20)      ,/* 資料建立者 */
faakcrtdp       varchar2(10)      ,/* 資料建立部門 */
faakcrtdt       timestamp(0)      ,/* 資料創建日 */
faakmodid       varchar2(20)      ,/* 資料修改者 */
faakmoddt       timestamp(0)      ,/* 最近修改日 */
faakstus       varchar2(10)      ,/* 狀態碼 */
faakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faak_t add constraint faak_pk primary key (faakent,faakld,faak000,faak001,faak003,faak004) enable validate;

create unique index faak_pk on faak_t (faakent,faakld,faak000,faak001,faak003,faak004);

grant select on faak_t to tiptop;
grant update on faak_t to tiptop;
grant delete on faak_t to tiptop;
grant insert on faak_t to tiptop;

exit;
