<?php

declare(strict_types=1);

namespace Difra\Bootstrap4;

use Difra\Debugger;
use Difra\Envi\Action;
use Difra\Events\Event;

/**
 * Class Plugin
 * @package Difra\Plugins\Bootstrap4
 */
class Plugin extends \Difra\Plugin
{
    /**
     * @inheritdoc
     * @throws \Difra\Exception
     */
    protected function init(): void
    {
        \Difra\Events\System::getInstance(Event::EVENT_RENDER_INIT)->registerHandler([static::class, 'addHTML']);
    }

    /**
     * @throws \Difra\Exception
     * @throws \Difra\View\HttpError
     */
    public static function addHTML(Event $event)
    {
        $html = Action::getController()->html;
        if (!Debugger::isEnabled()) {
            $html->getHead()->addStylesheet('/bootstrap4/css/bootstrap.min.css');
            $html->getBody()->addScript('/bootstrap4/js/bootstrap.min.js');
        } else {
            $html->getHead()->addStylesheet('/bootstrap4/css/bootstrap.css');
            $html->getBody()->addScript('/bootstrap4/js/bootstrap.js');
        }
    }
}

