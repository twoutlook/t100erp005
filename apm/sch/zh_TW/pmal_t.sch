/* 
================================================================================
檔案代號:pmal_t
檔案名稱:採購控制組供應商預設條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmal_t
(
pmalent       number(5)      ,/* 企業編號 */
pmal001       varchar2(10)      ,/* 交易對象編號 */
pmal002       varchar2(10)      ,/* 控制組編號 */
pmal003       varchar2(10)      ,/* 慣用交易幣別 */
pmal004       varchar2(10)      ,/* 慣用稅務規則 */
pmal005       varchar2(10)      ,/* 慣用發票開立方式 */
pmal006       varchar2(255)      ,/* 慣用付款條件 */
pmal008       varchar2(10)      ,/* 慣用採購通路 */
pmal009       varchar2(10)      ,/* 慣用採購分類 */
pmal010       varchar2(6)      ,/* 慣用報表語言 */
pmal011       varchar2(10)      ,/* 慣用交運方式 */
pmal012       varchar2(10)      ,/* 慣用交運起點 */
pmal013       varchar2(10)      ,/* 慣用交運終點 */
pmal014       varchar2(10)      ,/* 慣用卸貨港 */
pmal015       number(20,6)      ,/* 慣用佣金率 */
pmal016       number(20,6)      ,/* 折扣率 */
pmal017       varchar2(10)      ,/* 慣用ForWarder */
pmal018       varchar2(80)      ,/* 慣用Notify */
pmal019       varchar2(20)      ,/* 負責採購人員 */
pmal020       varchar2(10)      ,/* 慣用交易條件 */
pmal021       varchar2(10)      ,/* 慣用取價方式 */
pmal022       varchar2(2)      ,/* 慣用票類型 */
pmal023       varchar2(10)      ,/* 慣用內外購 */
pmal024       varchar2(10)      ,/* 慣用匯率計算基準 */
pmalownid       varchar2(20)      ,/* 資料所有者 */
pmalowndp       varchar2(10)      ,/* 資料所屬部門 */
pmalcrtid       varchar2(20)      ,/* 資料建立者 */
pmalcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmalcrtdt       timestamp(0)      ,/* 資料創建日 */
pmalmodid       varchar2(20)      ,/* 資料修改者 */
pmalmoddt       timestamp(0)      ,/* 最近修改日 */
pmalstus       varchar2(10)      ,/* 狀態碼 */
pmal025       varchar2(10)      ,/* 負責採購部門 */
pmalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmal_t add constraint pmal_pk primary key (pmalent,pmal001,pmal002) enable validate;

create unique index pmal_pk on pmal_t (pmalent,pmal001,pmal002);

grant select on pmal_t to tiptop;
grant update on pmal_t to tiptop;
grant delete on pmal_t to tiptop;
grant insert on pmal_t to tiptop;

exit;
