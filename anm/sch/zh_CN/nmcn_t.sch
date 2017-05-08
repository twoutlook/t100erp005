/* 
================================================================================
檔案代號:nmcn_t
檔案名稱:應收票據主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmcn_t
(
nmcnent       number(5)      ,/* 企業編號 */
nmcnownid       varchar2(20)      ,/* 資料所有者 */
nmcnowndp       varchar2(10)      ,/* 資料所屬部門 */
nmcncrtid       varchar2(20)      ,/* 資料建立者 */
nmcncrtdp       varchar2(10)      ,/* 資料建立部門 */
nmcncrtdt       timestamp(0)      ,/* 資料創建日 */
nmcnmodid       varchar2(20)      ,/* 資料修改者 */
nmcnmoddt       timestamp(0)      ,/* 最近修改日 */
nmcncnfid       varchar2(20)      ,/* 資料確認者 */
nmcncnfdt       timestamp(0)      ,/* 資料確認日 */
nmcnstus       varchar2(10)      ,/* 狀態碼 */
nmcncomp       varchar2(10)      ,/* 法人 */
nmcnsite       varchar2(10)      ,/* 營運據點 */
nmcndocno       varchar2(20)      ,/* 單號 */
nmcndocdt       date      ,/* 單據日期 */
nmcnorga       varchar2(10)      ,/* 賬務歸屬組織 */
nmcn001       varchar2(10)      ,/* 繳款部門 */
nmcn002       varchar2(20)      ,/* 帳務人員 */
nmcn003       varchar2(10)      ,/* 交易對象代碼 */
nmcn004       varchar2(20)      ,/* 一次性交易對象識別碼 */
nmcn005       varchar2(20)      ,/* 票據號碼 */
nmcn006       varchar2(1)      ,/* 票據類別 */
nmcn007       varchar2(1)      ,/* 客票否 */
nmcn008       varchar2(255)      ,/* 發票人 */
nmcn009       date      ,/* 到期日 */
nmcn010       varchar2(10)      ,/* 幣別 */
nmcn011       number(20,6)      ,/* 原幣金額 */
nmcn012       number(20,10)      ,/* 匯率 */
nmcn013       number(20,6)      ,/* 本幣金額 */
nmcn014       varchar2(15)      ,/* 付款銀行 */
nmcn015       varchar2(1)      ,/* 票面利率種類 */
nmcn016       number(10,6)      ,/* 利率百分比 */
nmcn017       varchar2(1)      ,/* 票況 */
nmcn018       varchar2(10)      ,/* 託貼銀行帳戶編碼 */
nmcn019       varchar2(10)      ,/* 存提碼 */
nmcn020       varchar2(10)      ,/* 轉付對象客商碼 */
nmcn021       number(5,0)      ,/* 流通期間 */
nmcn022       varchar2(1)      ,/* 貼現利率種類 */
nmcn023       number(10,6)      ,/* 貼現率 */
nmcn024       number(5,0)      ,/* 貼現期間 */
nmcn025       number(20,6)      ,/* 撥款原幣金額 */
nmcn026       number(20,6)      ,/* 撥款本幣金額 */
nmcn027       varchar2(20)      ,/* 帳款單號 */
nmcn028       number(20,6)      ,/* 主帳套已沖原幣金額 */
nmcn029       number(20,6)      ,/* 主帳套已沖本幣金額 */
nmcn030       varchar2(10)      ,/* 主帳套本位幣二幣別 */
nmcn031       number(20,10)      ,/* 主帳套本位幣二匯率 */
nmcn032       number(20,6)      ,/* 主帳套本位幣二金額 */
nmcn033       number(20,6)      ,/* 主帳套本位幣二已沖金額 */
nmcn034       varchar2(10)      ,/* 主帳套本位幣三幣別 */
nmcn035       number(20,10)      ,/* 主帳套本位幣三匯率 */
nmcn036       number(20,6)      ,/* 主帳套本位幣三金額 */
nmcn037       number(20,6)      ,/* 主帳套本位幣三已沖金額 */
nmcn038       varchar2(10)      ,/* 次帳套一幣別 */
nmcn039       number(20,6)      ,/* 次帳套一原幣已沖 */
nmcn040       number(20,6)      ,/* 次帳套一本幣已沖 */
nmcn041       varchar2(10)      ,/* 次帳套二幣別 */
nmcn042       number(20,6)      ,/* 次帳套二原幣已沖 */
nmcn043       number(20,6)      ,/* 次帳套二本幣已沖 */
nmcnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcn_t add constraint nmcn_pk primary key (nmcnent,nmcncomp,nmcndocno) enable validate;

create unique index nmcn_pk on nmcn_t (nmcnent,nmcncomp,nmcndocno);

grant select on nmcn_t to tiptop;
grant update on nmcn_t to tiptop;
grant delete on nmcn_t to tiptop;
grant insert on nmcn_t to tiptop;

exit;
