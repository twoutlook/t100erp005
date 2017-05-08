/* 
================================================================================
檔案代號:ooie_t
檔案名稱:款別主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ooie_t
(
ooieent       number(5)      ,/* 企業編號 */
ooiestus       varchar2(10)      ,/* 狀態碼 */
ooiesite       varchar2(10)      ,/* 營運據點 */
ooie001       varchar2(10)      ,/* 款別編號 */
ooie002       varchar2(10)      ,/* 款別指定幣別 */
ooie003       varchar2(1)      ,/* 第三方代收繳款否 */
ooie004       varchar2(10)      ,/* 代收機構 */
ooie005       number(20,6)      ,/* 代收手續費費率 */
ooie006       number(20,6)      ,/* 代收手續費金額 */
ooie007       varchar2(1)      ,/* 產生代收帳款單否 */
ooie008       varchar2(1)      ,/* 預設款別否 */
ooie009       varchar2(10)      ,/* 對應款別編號 */
ooie010       varchar2(500)      ,/* 顯示名稱 */
ooie011       varchar2(500)      ,/* 列印名稱 */
ooie012       varchar2(1)      ,/* 是否實收折讓 */
ooie013       varchar2(1)      ,/* 儲值付款單次使用否 */
ooie014       number(5,0)      ,/* 輸入號碼最小長度 */
ooie015       varchar2(1)      ,/* 可退款 */
ooie016       varchar2(1)      ,/* 可找零 */
ooie017       varchar2(1)      ,/* 下傳款別 */
ooie018       varchar2(1)      ,/* 可溢收 */
ooie019       varchar2(1)      ,/* 是否執行接口進程 */
ooie020       varchar2(1)      ,/* 扣款金額自動取值 */
ooie021       varchar2(1)      ,/* 接口小數倍數 */
ooie022       varchar2(1)      ,/* 允許空單交易 */
ooie023       varchar2(1)      ,/* transflag標記 */
ooie024       varchar2(80)      ,/* 接口進程返回的列印檔案 */
ooie025       varchar2(80)      ,/* 執行的接口進程 */
ooie026       varchar2(80)      ,/* 執行接口傳入的檔案名 */
ooie027       varchar2(80)      ,/* 執行接口傳入檔數據類型ID */
ooie028       varchar2(80)      ,/* 執行接口後返回接口檔 */
ooie029       varchar2(80)      ,/* 執行接口返回檔數據類型 */
ooiepos       varchar2(1)      ,/* 下傳否 */
ooiestamp       timestamp(5)      ,/* 時間戳記 */
ooieownid       varchar2(20)      ,/* 資料所有者 */
ooieowndp       varchar2(10)      ,/* 資料所有部門 */
ooiecrtid       varchar2(20)      ,/* 資料建立者 */
ooiecrtdp       varchar2(10)      ,/* 資料建立部門 */
ooiecrtdt       timestamp(0)      ,/* 資料創建日 */
ooiemodid       varchar2(20)      ,/* 資料修改者 */
ooiemoddt       timestamp(0)      ,/* 最近修改日 */
ooieud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooieud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooieud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooieud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooieud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooieud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooieud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooieud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooieud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooieud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooieud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooieud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooieud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooieud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooieud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooieud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooieud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooieud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooieud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooieud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooieud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooieud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooieud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooieud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooieud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooieud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooieud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooieud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooieud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooieud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ooie030       varchar2(20)      ,/* 對應的銀存帳戶 */
ooie031       number(20,6)      ,/* 標準卡手續費費率 */
ooie032       varchar2(10)      ,/* 券消費認列方式 */
ooie033       number(5,0)      ,/* 稅額扣抵順序 */
ooie034       varchar2(1)      ,/* 資金入帳是否当前據點 */
ooie035       varchar2(1)      ,/* 代收銀否 */
ooie036       varchar2(10)      ,/* 代收銀據點 */
ooie037       number(20,6)      ,/* 刷卡上限金額 */
ooie038       number(20,6)      ,/* 上限手續費金額 */
ooie039       varchar2(1)      ,/* 收銀繳款是否核對明細 */
ooie040       varchar2(10)      /* 手續費歸屬部門 */
);
alter table ooie_t add constraint ooie_pk primary key (ooieent,ooiesite,ooie001) enable validate;

create unique index ooie_pk on ooie_t (ooieent,ooiesite,ooie001);

grant select on ooie_t to tiptop;
grant update on ooie_t to tiptop;
grant delete on ooie_t to tiptop;
grant insert on ooie_t to tiptop;

exit;
