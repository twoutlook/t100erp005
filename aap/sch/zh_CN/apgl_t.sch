/* 
================================================================================
檔案代號:apgl_t
檔案名稱:外購到貨主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apgl_t
(
apglent       number(5)      ,/* 企業編號 */
apglcomp       varchar2(10)      ,/* 法人 */
apgldocno       varchar2(20)      ,/* 到貨單號 */
apgldocdt       date      ,/* 到貨日期 */
apgl001       date      ,/* 報關日期 */
apgl002       varchar2(10)      ,/* 供應商編號 */
apgl003       varchar2(20)      ,/* L/C NO */
apgl004       varchar2(20)      ,/* 申請單號 */
apgl005       varchar2(20)      ,/* 業務人員 */
apgl006       varchar2(10)      ,/* 報關行 */
apgl007       varchar2(20)      ,/* 裝運通知單號 */
apgl008       varchar2(10)      ,/* 運送方式 */
apgl009       varchar2(20)      ,/* 大提單單號 */
apgl010       varchar2(20)      ,/* 小提單單號 */
apgl011       date      ,/* 提單日期 */
apgl012       date      ,/* 起運日期 */
apgl013       date      ,/* 預計抵達日期 */
apgl014       varchar2(10)      ,/* 裝運公司 */
apgl015       varchar2(255)      ,/* 船名/航次 */
apgl016       varchar2(10)      ,/* 海關手冊 */
apgl017       varchar2(255)      ,/* 領櫃地點 */
apgl018       varchar2(255)      ,/* 領櫃編號 */
apgl019       varchar2(255)      ,/* 交櫃地點 */
apgl020       varchar2(255)      ,/* 櫃量 */
apgl021       date      ,/* 免費倉租日期 */
apgl022       varchar2(20)      ,/* 報單號碼 */
apgl023       varchar2(20)      ,/* 到單單號 */
apgl024       varchar2(20)      ,/* 稅款繳納證號 */
apgl025       number(5,2)      ,/* 營業稅率 */
apgl026       varchar2(10)      ,/* 扣抵編號 */
apgl027       number(20,6)      ,/* 本幣營業稅稅基 */
apgl028       number(20,6)      ,/* 本幣稅費合計 */
apgl029       varchar2(20)      ,/* 收貨/入庫單號 */
apgl030       varchar2(20)      ,/* 到貨費用應付憑單 */
apgl100       varchar2(10)      ,/* 幣別 */
apgl101       number(20,10)      ,/* 報單匯率 */
apgl103       number(20,6)      ,/* 到貨原幣金額 */
apglownid       varchar2(20)      ,/* 資料所有者 */
apglowndp       varchar2(10)      ,/* 資料所屬部門 */
apglcrtid       varchar2(20)      ,/* 資料建立者 */
apglcrtdp       varchar2(10)      ,/* 資料建立部門 */
apglcrtdt       timestamp(0)      ,/* 資料創建日 */
apglmodid       varchar2(20)      ,/* 資料修改者 */
apglmoddt       timestamp(0)      ,/* 最近修改日 */
apglcnfid       varchar2(20)      ,/* 資料確認者 */
apglcnfdt       timestamp(0)      ,/* 資料確認日 */
apglstus       varchar2(10)      ,/* 狀態碼 */
apglud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apglud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apglud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apglud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apglud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apglud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apglud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apglud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apglud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apglud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apglud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apglud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apglud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apglud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apglud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apglud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apglud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apglud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apglud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apglud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apglud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apglud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apglud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apglud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apglud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apglud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apglud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apglud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apglud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apglud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgl113       number(20,6)      /* 到貨本幣金額 */
);
alter table apgl_t add constraint apgl_pk primary key (apglent,apglcomp,apgldocno) enable validate;

create unique index apgl_pk on apgl_t (apglent,apglcomp,apgldocno);

grant select on apgl_t to tiptop;
grant update on apgl_t to tiptop;
grant delete on apgl_t to tiptop;
grant insert on apgl_t to tiptop;

exit;
