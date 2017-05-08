/* 
================================================================================
檔案代號:faaq_t
檔案名稱:資產月結資料檔(依帳套)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faaq_t
(
faaqent       number(5)      ,/* 企業代碼 */
faaqcomp       varchar2(10)      ,/* 歸屬法人 */
faaqsite       varchar2(10)      ,/* 營運據點 */
faaqld       varchar2(5)      ,/* 帳套 */
faaq001       number(5,0)      ,/* 年 */
faaq002       number(5,0)      ,/* 月 */
faaq003       varchar2(5)      ,/* nouse */
faaq004       varchar2(10)      ,/* 卡片編號 */
faaq005       varchar2(20)      ,/* 財產編號 */
faaq006       varchar2(20)      ,/* 附號 */
faaq007       varchar2(10)      ,/* 幣別 */
faaq008       number(20,10)      ,/* 匯率 */
faaq009       number(20,6)      ,/* 帳面原值(成本) */
faaq010       number(20,6)      ,/* 未折減額 */
faaq011       number(20,6)      ,/* 折舊額 */
faaq012       number(20,6)      ,/* 累計折舊 */
faaq013       number(20,6)      ,/* 減值準備金額 */
faaq014       number(20,6)      ,/* 預留殘值 */
faaq015       number(20,6)      ,/* 保險金額 */
faaq016       number(20,6)      ,/* 抵押金額 */
faaq017       number(20,6)      ,/* 租金金額 */
faaq100       varchar2(10)      ,/* 本位幣二幣別 */
faaq101       number(20,10)      ,/* 本位幣二匯率 */
faaq102       number(20,6)      ,/* 本位幣二成本 */
faaq103       number(20,6)      ,/* 本位幣二未折減額 */
faaq104       number(20,6)      ,/* 本位幣二折舊 */
faaq105       number(20,6)      ,/* 本位幣二累計折舊 */
faaq106       number(20,6)      ,/* 本位幣二減值準備金額 */
faaq107       number(20,6)      ,/* 本位幣二預留殘值 */
faaq108       number(20,6)      ,/* 本位幣二保險金額 */
faaq109       number(20,6)      ,/* 本位幣二抵押金額 */
faaq110       number(20,6)      ,/* 本位幣二租金金額 */
faaq120       varchar2(10)      ,/* 本位幣三幣別 */
faaq121       number(20,10)      ,/* 本位幣三匯率 */
faaq122       number(20,6)      ,/* 本位幣三成本 */
faaq123       number(20,6)      ,/* 本位幣三未折減額 */
faaq124       number(20,6)      ,/* 本位幣三折舊 */
faaq125       number(20,6)      ,/* 本位幣三累計折舊 */
faaq126       number(20,6)      ,/* 本位幣三減值準備金額 */
faaq127       number(20,6)      ,/* 本位幣三預留殘值 */
faaq128       number(20,6)      ,/* 本位幣三保險金額 */
faaq129       number(20,6)      ,/* 本位幣三抵押金額 */
faaq130       number(20,6)      ,/* 本位幣三租金金額 */
faaqownid       varchar2(20)      ,/* 資料所有者 */
faaqowndp       varchar2(10)      ,/* 資料所屬部門 */
faaqcrtid       varchar2(20)      ,/* 資料建立者 */
faaqcrtdp       varchar2(10)      ,/* 資料建立部門 */
faaqcrtdt       timestamp(0)      ,/* 資料創建日 */
faaqmodid       varchar2(20)      ,/* 資料修改者 */
faaqmoddt       timestamp(0)      ,/* 最近修改日 */
faaqstus       varchar2(10)      ,/* 狀態碼 */
faaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faaq_t add constraint faaq_pk primary key (faaqent,faaqld,faaq001,faaq002,faaq004,faaq005,faaq006) enable validate;

create unique index faaq_pk on faaq_t (faaqent,faaqld,faaq001,faaq002,faaq004,faaq005,faaq006);

grant select on faaq_t to tiptop;
grant update on faaq_t to tiptop;
grant delete on faaq_t to tiptop;
grant insert on faaq_t to tiptop;

exit;
